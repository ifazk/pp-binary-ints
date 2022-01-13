# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2022-01-12
### Changed
- Default flags have changed to padding with zeros, with separators and
  prefixes, and zero printing behaves just like non-zero printing. Since the
  primary purpose of this library is debugging, this should help.
- `*.{make_pp_int,make_to_string}` no longer take an optional `flags` parameter,
  and instead takes optional boolean parameters `zero_padding`, `left_padding`,
  `separators`, `prefix`, `suffix`, `zero_special`.
- Renamed `*.{pp_binary_int}` to `*.{pp_int_with}` for consistency.

### Fixed
- Padding with zeros no longer assumes prefixes are always 2 characters long.

## [0.1.1] - 2021-12-31
### Added
- Support for `int32`, `int64`, and `nativeint`.
- `*.{make_pp_int,make_to_string}` with optional arguments.

### Fixed
- Separators are now always respected, even when printing zero and
  `zero_printing` is set to `OCaml`. In `Stdlib`, padding with zeros means you
  pad with zeros without separators, but previously we thought this was only the
  case for printing zero. This has been fixed to always respect the separators
  flag.

## [0.1.0] - 2021-12-29

Initial release.
