oasis = require("oasis")
darcs = require("darcs")
ci = require("ci")
dist = require("dist")

ci.init()
oasis.init()
darcs.init()

ci.prependenv("PATH", "/usr/opt/godi/bin")
ci.prependenv("PATH", "/usr/opt/godi/sbin")
ci.putenv("OUNIT_OUTPUT_HTML_DIR", dist.make_filename("ounit-log.html"))
ci.putenv("OUNIT_OUTPUT_FILE", dist.make_filename("ounit-log.txt"))

oasis.std_process()
darcs.create_tag(oasis.package_version())