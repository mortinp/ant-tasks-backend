ant-tasks-backend
=================

This is a backend environment for executing ANT tasks in a chained manner (i.e. tasks depend on each other). You could build a front-end application above this environment (I have done it).

Introduction
============

This packages set up an environment for executing ANT tasks in a chained way (i.e. tasks depend on each other).

Each task belong to one category. Categories specify the main action its tasks execute and correspond to one step in an auto-build process. For example, we could have the category 'javac-compile', to which tasks 'javac' (compile Java code with javac) or 'gcc' (compile C code with gcc) may belong.

The following are the categories currently defined and its tasks:
* export
  	* svn-export
	* git-export
* compile
	* javac-compile
* test
	* junit-test
* build
	* custom-build
* database
	* postgres-dump
	* sql-backup
* doc
	* javadoc
* deploy
	* ftp-transfer
	* http-upload
	
The categories hierarchy is based in a layout of directories that matches the hierarchy; for example, we have the directories 'tasks/compile/javac-compile' and 'tasks/deploy/ftp-transfer'.

We employ a technique for establishing dependency relationships between different catgories of tasks. For this we make use of a file named 'dependencies.xml', which is a regular ANT file. Tasks in 'dependencies.xml' are executed on one condition: if the task is specified in the 'specific-tasks.properties' file. So we can control the tasks to execute by modifying 'specific-tasks.properties'.

The file 'build-common.xml' imports 'dependencies.xml', which allows us to invoke tasks in the latter file from the former. 'build-common.xml' has only one task: 'do.with.dependencies'. This task triggers the initial task in 'dependencies.xml', which at the same time executes tasks in the order specified by the dependencies chain. Each task in 'dependencies.xml' invokes the 'default' target in a specific directory corresponding a specific task. This ensures that specific tasks are called in the order established by the category they belong to, which is our main goal.

How to use it
=============

Simply specify the tasks you want to execute in the file 'specific-tasks.properties' (order doesn't matter) and run 'invoke-entry<.bat>' script, or invoke<.bat> script passing two parameters: category and task (ex. invoke "deploy" "ftp-transfer").
Make sure to follow the conventions when editing 'specific-tasks.properties' (you should be able to discover the conventions easily).

How to extend it
================

You can create new tasks inside the categories already defined by just creating a new directory for that task inside the corresponding category folder, and create its 'build.xml' file.

The 'build.xml' file should conform to the following conventions:
* The project name should be the name of the category.
* Have a task named 'default' (which is the one that will be invoked).

To create a new category you should create a folder with the name of the category inside the 'tasks' directory, and the folders and 'build.xml' file for each specific task. Then you should create a target for this category in 'dependencies.xml', and define or reasemble all the dependencies.

To invoke a new task or category, just edit 'specific-tasks.properties' and run 'invoke<.bat>' script.
