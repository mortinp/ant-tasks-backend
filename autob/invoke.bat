@echo off

set script_dir=%~dp0
set script_dir=%script_dir%##
set script_dir=%script_dir:\##=##%
set script_dir=%script_dir:##=%

set ANT_HOME=%script_dir%/3p/ant
set PATH=%PATH%;%ANT_HOME%/bin

set category=%1
set task=%2

set ant_lib_extras=%script_dir%/3p/ant/lib/extras

cd ..

rem Add the following in the ant invocation to send output to $script_dir/temp/build_log.xml file:
rem -logger org.apache.tools.ant.XmlLogger -logfile "%script_dir%/temp/build_log.xml"
ant -lib "%ant_lib_extras%"  -buildfile "tasks/%category%/%task%/build.xml" do.with.dependencies
pause
