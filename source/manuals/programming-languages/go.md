---
title: Go style guide
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2024-04-23
review_in: 12 months
owner_slack: '#golang'
permalink: manuals/programming-languages/go.html
---

> Note: [Go is no longer a core language](/standards/programming-languages.html#go)
for backend development in GDS.

The purpose of this style guide is to provide some conventions for working on Go code within GDS. There are already good resources on writing Go code, which are worth reading first:

* [Effective Go](https://golang.org/doc/effective_go)
* [Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments) (documenting points that have been raised in Google code reviews)

## Code formatting

Use [`gofmt`](https://golang.org/cmd/gofmt/). This means all Go code reads in the same way which is [important when looking at unfamiliar code](https://blog.golang.org/go-fmt-your-code).

You may also want to use [`golint`](https://github.com/golang/lint) which assesses code style.

## Code checking

[`go vet`](https://golang.org/cmd/vet/), which checks correctness, should be used as part of your build process.

If you are writing concurrent code, use the [race detector](https://blog.golang.org/race-detector) to detect race conditions.

## External dependencies

As of Go 1.11 there is an [officially developed module system](https://blog.golang.org/using-go-modules), which is finalized in Go 1.13: `go mod`.

A historical pain point of development in Go was the manipulation of `$GOPATH` which is no longer required when using `go mod`.

There are several Go depency management tools in use at GDS, other than `go mod`:

- [dep](https://golang.github.io/dep/) (no longer in development)
- [godep](https://github.com/tools/godep) (no longer in development)
- [glide](https://github.com/Masterminds/glide) (no longer in development)
* [gopkg.in](https://labix.org/gopkg.in), which provides a method of using versioned import paths
* vendoring (ie copying source code in some manner to a location you control)

All new projects should use the officially developed `go mod` unless they have specific requirements not met by `go mod`

Vendoring is still common practice in Go, but if you are using `go mod` with Go
1.13+ then the go command will download and authenticate modules from the
highly available [Go module mirror](https://pkg.go.dev/cmd/go#hdr-Configuration_for_downloading_non_public_code) and Go checksum database run by Google which
alleviates the need to vendor your modules

## Web frameworks

While it's difficult to provide any guidance that will be generally applicable, there are couple of useful things to consider when structuring your Go program.

The first is that Go's standard library is modern and powerful. If you just need simple HTTP routing and handling, the [`net/http` package will probably meet your needs](https://golang.org/doc/articles/wiki/).

The second is that if `net/http` falls short, it's worth choosing something that integrates well with it.

The third is that Go is not a language we use at GDS for developing fully-fledged web applications, eg rendering HTML. If you find yourself rendering HTML using Go, consider using a different GDS supported language.

## Channels

### Signalling

Channels that are being used purely for signalling should use an
empty struct rather than boolean or int types.

Using an empty struct declares that we're not interested in the value
sent or received; only in its closed property.

See [this talk](https://talks.golang.org/2012/10things.slide#11)

```go
func worker(quit <-chan struct{}, result chan<- int) {
  for {
    select {
    case result <- rand.Intn(10000000):
    case <-quit:
      return
    }
  }
}

func main() {
  quit, result := make(chan struct{}), make(chan int)
  for i := 0; i < 100; i++ {
    go worker(quit, result)
  }
  // Wait for a worker to return a good result
  for {
    if <-result > 9999998 {
      break
    }
  }
  close(quit) // terminate all the workers
  fmt.Println("All done!")
}
```

## Testing

There is some use across GDS of [gomega](https://onsi.github.io/gomega/) for matching, and [ginkgo](https://onsi.github.io/ginkgo/) for BDD testing.

If you find yourself writing too much boilerplate when testing Go, consider reaching for these libraries.

Gomega can help make your tests more readable:

```
err := doAThing() // this should fail
Expect(err).Should(HaveOccurred())
```

And Ginkgo can help set up a test suite:

```
var _ = Describe("Something", func() {
  It("should do a thing", func() {

    Expect("hi").To(HaveLen(2))

  })
})
```

which can be run with:

```
ginkgo
```

Tests can be focused (using regular expressions), to speed up development:

```
ginkgo -focus 'a thing'
```

## Configuration parsing

There are a number of tools in use at GDS for parsing configuration and arguments:

- [alecthomas/kingpin](https://github.com/alecthomas/kingpin) (not actively maintained) for parsing simple command line arguments and environment variables
- [urfave/cli](https://github.com/urfave/cli) for building more advanced CLI tools
- [spf13/viper](https://github.com/spf13/viper) for parsing configuration files

These tools can make it easier to accept configuration parameters and help to make your application self-documenting.
