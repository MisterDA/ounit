## v2.1.0 - 2019-09-22

### Added
- New logger for CI, like Travis and AppVeyor, with colored output. It is
  enabled by adding OUNIT_CI=true to environment section of .travis.yml or
  appveyor.yml.
- ounit-lwt to build test with OUnit and Lwt. It also allows
  to use the runner "processes" to run test in parallel. (Closes: OF#1765)

### Changed
- assert_command only displays the difference with the initial environment.
  This avoids to have hundreeds of lines of useless environment variables.
- Upgrade minimal OCaml version to 4.02, since dune requires at least this
  version.

### Fixed
- Run garbage collection in between tests to prevent unexpected bugs in GC (e.g
  finaliser throwing exceptions). (Closes: OF#1766)

## v2.0.8

- Handle infinity and NaN in cmp_float, thanks to Johannes Kloos
  (Closes: OF#1381)

## v2.0.7

- Prevent OUnitLoggerJUnit to fail when the hostname cannot be found, thanks
  to Bailey Parker for the fix (Closes: OF#1744)

## v2.0.6

- Fix internal uppercase_name.

## v2.0.5

- Allow to recover from interrupted Unix.select call. This allows to
  run more reliably the RunnerProcess with lwt. (Closes: OF#1363)

## v2.0.4

- minor bug fixes:
  - replace String.map by Buffer.* to be compatible with OCaml < 4.0.

## v2.0.3

- minor bug fixes:
  - use Marshal.from_string to be compatible with OCaml <= 4.01.
  - declare dependency on bytes in _oasis

## v2.0.2

- minor bug fixes:
  - replace String.uppercase_ascii.

## v2.0.1

- minor bug fixes
- fix safe-string compatibility issuesi, thanks to Christoph Spiel
  (Closes: OF#1760, OF#1761)
- fix some format string errors, thanks to Damien Doligez (Closes: OF#1422)
- fix backward incompatiblity with OUnit v1 (Closes: OF#1392)

## v2.0.0

- major rewrite of all the code!
- implements a quickfix compatible way of outputing failures, it jumps to
  the a position in the logfile to help you debug the problem.
- better configuration setup: environment variable, command line options,
  configuration files (OUnitConf)
- improved output of the tests: output HTML report, output JUnit report,
  systematic logging to a file (OUnitLogger*)
- choose how to run a test: in parallel using processes (auto-detect number
  of CPU), concurrently using threads or sequentialy as before.
- choose which test to run: just run test in sequence (simple) or run the
  tests that failed in the last run first and skip the success if they are
  still failing (failfirst) (OUnitChooser)
- OUnitBracket: use a registration in the context to make it easier to use
- remove all useless functions in the OUnit2 interface
- non-fatal section: allow to fail inside non-fatal section without
  quitting immediately the whole test
- refactor OUnit.ml to still provides the same function but using OUnit2.
-  timer that makes tests fail if they take too long (runner = processes)
- allow to parametrize filenames so that you can use
  OUNIT_OUTPUT_FILE=ounit-$(suite_name)-$(shard_id).log
  and have $(suite_name) replace by the test suite name
- create locks to avoid accessing the same resources within a single process
  or the whole application (OUnitShared)
- OUnitTestData locate test data, if any.
- enforce environment cleanness by checking it before and after the test
  (e.g check that Sys.getcwd is the same).

## v1.1.2

- regenerate with oasis v0.3.0~rc6

## v1.1.1

- bracket now enforce returning unit
- update examples
- ListSimpleMake now use the provided comparator for all elements

## v1.1.0

- Add a ~pp_diff parameter to assert_equal and some classic diff operations
  (Closes: OF#635, OF#642)
- Add an assert_command function (Closes: OF#641)
- Add a bracket_tmpfile to ease temporary file use
- Enhance documentation, translate the docbook manual into ocamldoc and
  add content
- Allow to add extra command line arguments to run_test_tt_main
  (Closes: OF#640)
- Add a -list-test options to run_test_tt_main, to list available tests
- Skip tests when using "-only-test", rather than removing it. This way
  the path is the same even if some tests don't pass (Closes: OF#637)
- Add backtrace support (Closes: OF#639), thanks to Michael Ekstrand
- Use OASIS
- Move to OCaml Forge: http://ounit.forge.ocamlcore.org
- Maintainance is now done by Sylvain Le Gall (OCamlCore SARL), thanks to
  Maas-Maarten Zeeman for all his work

## v1.0.3

- Add the possibility to skip test and mark tests as todo

## v1.0.2

- Refactored OUnit package. The test result and test event data structures
  are now clearly separated.

## v1.0.1

- Added optional compare function to assert_equal, and a float compare
  function. Thanks go to Daniel Buenzli

## v1.0.0

- Add bracket support (Thanks go to Laurent Vaucher)
- Add an example for bracket usage

## v0.1.0

- Makefile improvements

## v0.0.3

- Added findlib support

## v0.0.2

- Added assert_raises which checkes if an exception is raised.
  (thanks go to Keita Yamaguchi, for the idea)
- Fixed (hopefully) the .depend file

## v0.0.1

- First release of ocaml-unit

## Changelog format
The format is loosely based on [Keep a Changelog], and this project adheres to
[Semantic Versioning].

[Keep a Changelog]: https://keepachangelog.com/en/1.0.0
[Semantic Versioning]: https://semver.org/spec/v2.0.0.html

## BTS references

* OF#XX: OCaml Forge BTS (pre-2019)