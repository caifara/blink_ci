# BlinkCi

This gem is an experiment to create an easy CLI to monitor a jenkins CI server using a Blink(1).

## Features

Blink(1) is:

* Green if all is well
* Red if a project failed
* Blue/green-breathing if a project is building and all was well
* Blue/red-breathing if a project is building and a project had a failure

## Installation

    gem install blink_ci

## Usage

    blink_ci -u user -p password -h jenkins.example.com

-u and -p are optional.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
