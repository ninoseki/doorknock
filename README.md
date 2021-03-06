# Doorknock

[![Build Status](https://travis-ci.org/ninoseki/doorknock.svg?branch=master)](https://travis-ci.org/ninoseki/doorknock)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/doorknock/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/doorknock?branch=master)

A doorknocking tool targeting phishing admin panels.

## Installation

```bash
% gem install doorknock
```

## Usage

```bash
% doorknock
Commands:
  doorknock crawl           # crawl & knock phishing websites
  doorknock help [COMMAND]  # Describe available commands or one specific command
  doorknock knock URL       # knock a given URLs

% doorknock help crawl
Usage:
  doorknock crawl

Options:
  [--size=N]  # Number of urlscan.io's search results to check. (Max: 10,000)
              # Default: 100

crawl & knock phishing websites

% doorknock help knock
Usage:
  doorknock knock URL

knock a given URL
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
