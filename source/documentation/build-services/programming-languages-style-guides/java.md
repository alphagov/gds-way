---
title: Java style guide
last_reviewed_on: 2018-11-09
review_in: 6 months
---

### Java

The purpose of this style guide is to provide some conventions for working on Java code within GDS. The old [Sun/Oracle Java style guide](https://www.oracle.com/technetwork/java/index-135089.html) is a useful start.

Generally [IntelliJ IDEA](https://www.jetbrains.com/idea/) is used within GDS and consistency of its use helps when pairing and mob programming.

We favour consistency across our code, so when considering using a new or different method or paradigm to what exists already, ensure that you have agreement of your team.

#### Code formatting

Variable and field names should match the class they are instantiating, or have a descriptive name in the context of their use.

Use the [GDS Way EditorConfig file](editorconfig), which has settings for things like code indentation. Place a copy of this file named `.editorconfig` in the root of your project to have IntelliJ IDEA and some other editors automatically apply the settings. If your editor does not support EditorConfig, manually configure its settings to match.

#### Dependency injection (DI)

Consider whether dependency injection is appropriate for your project before using it. Some programmes use the [Guice](https://github.com/google/guice) dependency injection framework.

#### Imports

No wildcard imports should be used.  IntelliJ can be configured to explicitly import all classes and static methods in `Code Style->Java->Imports` with `Class count to use import with '*'` and `Names count to use static import with '*'` both set to a very high number, i.e. 1000.

The IntelliJ "Optimize imports" command helps to sorting them alphabetically and removes any that are unused.

#### Code checking

The use of static analysis is encouraged. Static analysis tools for Java include [SonarQube](https://www.sonarqube.org/), [Codacy](https://www.codacy.com/), [FindBugs](http://findbugs.sourceforge.net/) and [CheckStyle](http://checkstyle.sourceforge.net/). However, be aware that such tools can detect an overwhelming number of problems if applied to an existing project, which tends to result in their checks being ignored.

Try to minimise compiler warnings. If you cannot remove a warning, use an appropriate annotation to suppress it, preferably with a comment explaining why. For example:

```java
public void frobulateFoos() {
    LOGGER.info("Frobulating foos");

    // LibFoo returns a raw list but every element is always a Foo
    @SuppressWarnings("unchecked")
    List<Foo> foos = (List<Foo>) fooService.getFoos();

    foos.forEach(foo -> foo.frobulate());
}
```

## Build tools

Either Gradle or Maven should be used as the build tool.

#### Web frameworks

We use [Dropwizard](https://www.dropwizard.io/) as our web framework of choice.

If you are sending logs to a service that requires them in a specific format, you may find our [dropwizard-logstash](https://github.com/alphagov/dropwizard-logstash) logging extension useful.
