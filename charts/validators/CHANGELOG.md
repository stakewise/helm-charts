# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2022.02
### Added
- Support for multiple beaconChainRpcEndpoints
### Changed
- All dependencies are now installed separately to simplify the installation and maintenance process
- beaconChainRpcEndpoint changed from string to list with ability to specify multiple eth2 endpoints
- vaultEndpoint should be specified manually in all cases
### Removed
- geth, erigon, prysm, lighthouse, teku, vault dependencies

## [2.0.1] - 2022.01
### Added
- Gnosis Chain Support
### Changed
- Added Gnosis Chain compatible binaries to Dockerfile
- Added Gnosis Chain support to validator init script
