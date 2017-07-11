---
title: Logging howtos
layout: default
---

## Standard field names

In order to make logs easier to query, we should adopt a standard set
of field names for sending logs.

### Naming conventions

We should use current logstash naming conventions, as documented in
[LOGSTASH-675](https://logstash.jira.com/browse/LOGSTASH-675).  In particular:

  - the only guaranteed fields are `@timestamp` and `@version`
  - `@version` is always `1`
  - `@timestamp` is always an ISO-8601 formatted timestamp
  - you shouldn't prefix field names with `@fields.`
  
We should use the
[elastic beats naming conventions](https://www.elastic.co/guide/en/beats/libbeat/current/event-conventions.html).  In particular:

  - fields are lower case and `snake_case`
  - use dots to group related metrics, eg `cpu.user` and `cpu.system`
  
An alternative to using dots to group related metrics is to use a
nested document.  For example: `"cpu": {"user":30.0,"system":40.0}`

### HTTP fields

Lots of fields related to http access logs should be grouped under the
`http` namespace.

  - `status`
      - type: integer
      - meaning: HTTP status code
      - If the status code does not exist for some reason (say,
        because the connection was closed or reset before the status
        was sent) then a special value can be used, or the field can
        be dropped
      - examples: `200`, `404`
  - `method`
      - type: string
      - meaning: HTTP method used in request
      - examples: `"GET"`, `"POST"`
  - `path`
      - type: string
      - meaning: HTTP path, *excluding* query string
      - example: `/foo/bar/baz`
  - `query_string`
      - type: string
      - meaning: HTTP query string, *excluding* inital question mark
        character
      - example: `foo=bar&baz=quux`

Example:

```json
{
  "@version": 1,
  "@timestamp": "2017-07-11T15:49:00Z",
  "http": {
    "status": 404,
    "method": "GET"
  }
}
```

## Advice for particular application frameworks

### Dropwizard

The
[dropwizard-logstash](https://github.com/alphagov/dropwizard-logstash)
library will set things up for you using the standard names.

## Advice for particular environments

### Cloud Foundry

The
[Cloud Foundry documentation for logit](https://docs.cloudfoundry.org/devguide/services/log-management-thirdparty-svc.html#logit)
will help you drain logs from your app into logit.

Here is some logstash configuration to process the cloud foundry logs
into separate gorouter and application log types:

```
filter {
    grok {
        match => { "message" => "%{SYSLOG5424PRI}%{NONNEGINT:syslog_ver} +(?:%{TIMESTAMP_ISO8601:syslog_ts}|-) +(?:%{HOSTNAME:syslog_host}|-) +(?:%{NOTSPACE:syslog_app}|-) +(?:%{NOTSPACE:syslog_proc}|-) +(?:%{WORD:syslog_msgid}|-) +(?:%{SYSLOG5424SD:syslog_sd}|-|) +%{GREEDYDATA:syslog_msg}" }
    }
    syslog_pri { }
    date {
        match => [ "syslog_ts", "ISO8601" ]
    }
    if !("_grokparsefailure" in [tags]) {
        mutate {
            replace => [ "@source_host", "%{syslog_host}" ]
            replace => [ "@message", "%{syslog_msg}" ]
        }
    }
    if [syslog_proc] =~ "RTR" {
        grok {
            match => { "syslog_msg" => "%{HOSTNAME:router_host} - \[%{TIMESTAMP_ISO8601:router_timestamp}\] \"%{WORD:http_method} %{NOTSPACE:http_path} HTTP/1\.1\" %{NONNEGINT:http_status} %{NONNEGINT:http_request_size} %{NONNEGINT:http_size} %{QUOTEDSTRING:http_referer} %{QUOTEDSTRING:http_user_agent} \"%{HOSTPORT:remote_addr}\" \"%{HOSTPORT:dest_ip_and_port}\" %{GREEDYDATA:router_keys}" }
            tag_on_failure => ["_routerparsefailure"]
        }
        kv {
            source => "router_keys"
            target => "router"
            value_split => ":"
        }
    }
    if [syslog_proc] =~ "APP" {
        json {
            source => "syslog_msg"
            target => "app"
        }
        if [app.logger_name] == "http.request" {
            
        }
    }
}
```

