# Tasks

[![Build Status](https://travis-ci.org/jcampbell05/Tasks.svg?branch=master)](https://travis-ci.org/jcampbell05/Tasks)
[![Latest Release](https://img.shields.io/github/release/jcampbell05/tasks.svg)](https://github.com/jcampbell05/tasks/releases/latest)
![Platforms](https://img.shields.io/badge/platforms-Linux%20%7C%20OS%20X-blue.svg)
![Package Managers](https://img.shields.io/badge/package%20managers-SwiftPM-yellow.svg)

> Run shell scripts from your Swift code. Linux &amp; OS X ready.

# Usage

```swift
do {
	let result = try Task.run("echo", "unicorns")
	print(result.code) //0
	print(result.stdout) //"unicorns"
	print(result.stderr) //""
} catch {
	print("Unexpected task error: \(error)")
}
```

# Installation

## Swift Package Manager

```swift
.Package(url: "https://github.com/czechboy0/Tasks.git", majorVersion: 0, minor: 4)
```

:blue_heart: Code of Conduct
------------
Please note that this project is released with a [Contributor Code of Conduct](./CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

:gift_heart: Contributing
------------
Please create an issue with a description of your problem or open a pull request with a fix.

:v: License
-------
MIT

:alien: Author
------
Honza Dvorsky - http://honzadvorsky.com, [@czechboy0](http://twitter.com/czechboy0)
