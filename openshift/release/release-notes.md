# OpenShift Pipelines 1.5

# Tekton CLI v0.19.1

### Fixes 🐛

Fix default --prefix=false with p/t/ct start [#1405](https://github.com/tektoncd/cli/pull/1405) 
Fix version command outputting empty[#1390](https://github.com/tektoncd/cli/pull/1390) 

# Tekton CLI v0.19.0

### Features ✨

* Tkn task, clustertask and pipeline start will interactively ask for params value if not default specified and not passed [#1180](https://github.com/tektoncd/cli/pull/1180) [#1379](https://github.com/tektoncd/cli/pull/1379) [#1376](https://github.com/tektoncd/cli/pull/1376)
* Lookup plugins in current path if not in plugins dir [#1366](https://github.com/tektoncd/cli/pull/1366)
* Add support for optional workspaces in start command [#1377](https://github.com/tektoncd/cli/pull/1377)
* Add tkn hub check-upgrade command, other commands refactored to be based on pipeline version and show catalog name in searcch command output [#1369](https://github.com/tektoncd/cli/pull/1369)
* Add --component flag to tkn version command for specific component version [#1093](https://github.com/tektoncd/cli/pull/1093)
* Add a flag --prefix=false to not print the taskname/step prefix when showing logs [#1304](https://github.com/tektoncd/cli/pull/1304)

### Fixes 🐛

* Fix validation error if any param has not type defined and is passed using -f flag [#1069](https://github.com/tektoncd/cli/pull/1069)
* Consistent and details description for workspace flag in start commands [#1354](https://github.com/tektoncd/cli/pull/1354)