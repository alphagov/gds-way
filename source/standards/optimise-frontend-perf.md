---
title: How to optimise frontend performance
eleventyNavigation:
  parent: Software development
owner_slack: "#frontend"
last_reviewed_on: 2024-05-10
review_in: 6 months
permalink: standards/optimise-frontend-perf.html
---

You should focus on [frontend performance][] when developing your service’s website. This will improve the user experience of your service by making your website respond faster and work better on all devices.

## Prioritise performance tasks

You can optimise your site’s frontend performance by prioritising tasks that will improve your site speed. Prioritise things you must do (high) over nice to have (medium or low priority) tasks.

For example:

| Priority | Example                                                                          | Action                                                                                                                                                                                                                                                         |
| -------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| #High    | Position assets correctly                                                        | [Set styles at the top of the page][] and [`defer` scripts][].                                                                                                                                                                                                 |
|          | Compress static resources                                                        | [Minify][] CSS and JavaScript and use a compression algorithm like [Gzip][] and [Brotli][] on assets.                                                                                                                                                          |
|          | Set correct Headers                                                              | Set correct [Cache-Control][] and [ETag][] headers on assets for optimal caching.                                                                                                                                                                              |
|          | Minimise unused code                                                             | Avoid including CSS and JavaScript that is not used on your site.                                                                                                                                                                                              |
| #Medium  | Include `width` and `height` attributes on images to minimise layout thrashing   | Make sure to include these attributes to improve visual stability and the [Cumulative Layout Shift (CLS)][] metric.                                                                                                                                            |
|          | Minimise TCP connections                                                         | Use fewer third-party domains to reduce the number of DNS + TCP + SSL negotiations per page.                                                                                                                                                                   |
|          | Investigate [lazy loading][]                                                     | For pages with many images, only load images in the immediate browser viewport.                                                                                                                                                                                |
|          | Investigate the impact of loading [@font-face][] assets on perceived performance | Use the CSS `font-display` property or other [font-loading strategies][] to manage common issues like [FOUT, FOIT and FOFT][].                                                                                                                                 |
|          | Minimise HTTP requests                                                           | Minimise the number of CSS and JavaScript files to reduce the number of round-trips to the server. See ‘Code splitting’ below.                                                                                                                                 |
| #Low     | Reduce cookie size                                                               | Because every cookie is sent with each HTTP request, enable HTTP/2 to enable HPACK header compression or HTTP/3 for QPACK.                                                                                                                                     |
|          | Investigate using a Content Delivery Network (CDN)                               | A CDN will improve site performance by using a network of servers to deliver resources to users. The user will get delivered resources from the server that is located nearest to the user. A CDN is well-suited to handling heavy traffic and traffic spikes. |
|          | Keep JSON payloads small                                                         | Avoid adding too much data to JSON objects, as parsing them can be slow.                                                                                                                                                                                       |
|          | Investigate using [WebSockets][]                                                 | Consider using WebSockets rather than [XMLHttpRequest][]for tasks involving streaming from the server - an HTTP request packet has 1,684 bytes of overhead, compared to 8 bytes for a WebSocket packet.                                                        |
|          | Investigate using a service worker                                               | Consider [using a service worker][] for fine grain cache control of critical assets on users’ machines instead of transferring them over the network.                                                                                                          |

## Automate optimisation

You can automate performance optimisation using tools such as:

- [Webpack][]
- [Parcel][]
- [Rollup][]
- [Gulp][]

You should integrate these tools into your [Continuous Delivery (CD) and Continuous Integration (CI) workflow][] so they automatically run before deployment.

Consider automating common tasks like:

- CSS and JavaScript linting and optimisation
- CSS and JavaScript minification
- image optimisation
- sprite and icon generation
- SVG optimisation

## Automate testing

You can automate frontend performance testing using third-party services such as:

- [WebPageTest][]
- [Google PageSpeed Insights][]
- [SpeedCurve][]
- [Sitespeed.io][]
- [Calibre][]

## Using Speedcurve to automate frontend performance testing

You can use [Speedcurve][] to test the performance of your service.

Speedcurve provides an extensive set of tools to test your service such as the following:

- Test from different locations and different browsers.
- Schedule regular tests using tools like Google Lighthouse and Webpage Test.
- [Real user monitoring][], which allows you to collect data that shows you how your real users experience the speed of your site.

Contact a Lead Frontend Developer to request an account.

## Performance budget

You should [set a performance budget][] for your website’s pages. Once you’ve set a performance budget, test to check your website’s pages stay within your budget. There are many tools available to do this, such as:

- [Webpack Performance][]
- [performance-budget][]
- [psi (PageSpeed Insights Reporting for Node)][]
- [Google Lighthouse][]

## Code splitting

You should [concatenate your Javascript and CSS files][] by default, as this minimises the number of requests and makes compression more effective. However, you may benefit from splitting your code into multiple bundles in some cases:

- if a specific feature is only used sporadically, it may make sense to split it out and only load it on pages where it is needed.
- if some of your code is updated more regularly than others, it may make sense to split it out so that less frequently updated code is still cached.

## Use HTTP/2 or above

HTTP/2 is supported in all of the [Service Manual’s browsers to test in][]. It improves speed for most users by allowing browsers to:

- Download multiple resources at once
- Compress cookies in request headers
- Prioritise specific assets for download.

You should also consider enabling HTTP/3. While this isn’t supported as widely as HTTP/2, it is supported by most of the Service Manual browsers and it solves an issue with HTTP/2 that affects users with slow connections.

## Further reading

You can find out more about improving your website’s frontend performance by reading:

- [web.dev - Fast load times][]
- [Setting a performance budget][]
- [My performance audit workflow][]
- [Front-end performance for web designers and front-end developers][]
- [Improving web app performance with the Chrome DevTools Timeline and Profiles][]
- [Google Web Fundamentals: Optimizing Content Efficiency][]

The Service Manual has more suggestions about [how you can test frontend performance][].

[frontend performance]: https://www.gov.uk/service-manual/technology/how-to-test-frontend-performance
[minification]: https://web.dev/reduce-network-payloads-using-text-compression/
[Gzip]: https://web.dev/optimizing-content-efficiency-optimize-encoding-and-transfer/#text_compression_with_gzip
[Cache-Control]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control
[ETag]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag
[lazy loading]: https://web.dev/fast/#lazy-load-images-and-video
[@font-face]: https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face
[FOUT, FOIT and FOFT]: https://css-tricks.com/fout-foit-foft/
[AJAX]: https://developer.mozilla.org/en-US/docs/Web/Guide/AJAX/Getting_Started
[WebSockets]: https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API
[XMLHttpRequest]: https://xhr.spec.whatwg.org/
[Webpack]: https://webpack.js.org/
[Parcel]: https://parceljs.org/
[Rollup]: https://rollupjs.org/guide/en/
[Gulp]: https://gulpjs.com/
[Speedcurve]: https://www.speedcurve.com/
[Real user monitoring]: https://insidegovuk.blog.gov.uk/2021/06/16/how-real-user-monitoring-will-improve-gov-uk-for-everyone/
[Continuous Delivery (CD) and Continuous Integration (CI) workflow]: https://www.gov.uk/service-manual/technology/deploying-software-regularly
[Google PageSpeed Insights]: https://pagespeed.web.dev/
[set a performance budget]: https://www.gov.uk/service-manual/technology/how-to-test-frontend-performance#set-a-performance-budget
[web.dev - Fast load times]: https://web.dev/fast/
[Setting a performance budget]: https://timkadlec.com/2013/01/setting-a-performance-budget/
[My performance audit workflow]: https://aerotwist.com/blog/my-performance-audit-workflow/
[Front-end performance for web designers and front-end developers]: https://csswizardry.com/2013/01/front-end-performance-for-web-designers-and-front-end-developers/
[Improving web app performance with the Chrome DevTools Timeline and Profiles]: https://addyosmani.com/blog/performance-optimisation-with-timeline-profiles/
[how you can test frontend performance]: https://www.gov.uk/service-manual/technology/how-to-test-frontend-performance
[Google Web Fundamentals: Optimizing Content Efficiency]: https://web.dev/performance-optimizing-content-efficiency/
[Brotli]: https://github.com/google/brotli
[HPACK]: https://blog.cloudflare.com/hpack-the-silent-killer-feature-of-http-2/
[QPACK]: https://quicwg.org/base-drafts/rfc9204.html
[Cumulative Layout Shift (CLS)]: https://web.dev/cls/
[WebPageTest]: https://www.webpagetest.org/
[Sitespeed.io]: https://www.sitespeed.io/
[Calibre]: https://calibreapp.com/
[Webpack Performance]: https://webpack.js.org/configuration/performance/
[performance-budget]: https://www.npmjs.com/package/performance-budget
[psi (PageSpeed Insights Reporting for Node)]: https://github.com/GoogleChromeLabs/psi
[Google Lighthouse]: https://github.com/GoogleChrome/lighthouse
[Set styles at the top of the page]: https://csswizardry.com/2013/01/front-end-performance-for-web-designers-and-front-end-developers/#section:styles-at-the-top-scripts-at-the-bottom
[`defer` scripts]: https://calendar.perfplanet.com/2016/prefer-defer-over-async/
[Minify]: https://web.dev/reduce-network-payloads-using-text-compression/
[Brotli]: https://github.com/google/brotli
[font-loading strategies]: https://www.zachleat.com/web/comprehensive-webfonts/
[using a service worker]: https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API/Using_Service_Workers
[concatenate your Javascript and CSS files]: https://csswizardry.com/2023/10/the-three-c-concatenate-compress-cache/
[Service Manual’s browsers to test in]: https://www.gov.uk/service-manual/technology/designing-for-different-browsers-and-devices
