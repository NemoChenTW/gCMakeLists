#!/bin/bash

CMAKELIST_FILE="CMakeLists.txt.sample"

# Insert new line to file
function newLine()
{
	if [[ $# > 0 ]]; then
		count=$1
	else
		count=1
	fi

	for (( i = 0; i < $count; i++ )); do
		echo "" >> $CMAKELIST_FILE
	done
}

function writeToFile()
{
	echo $1 > $CMAKELIST_FILE
}

function appendToFile()
{
	echo "$1" >> $CMAKELIST_FILE
}

# Version setting
writeToFile "CMAKE_MINIMUM_REQUIRED(VERSION 3.2)"

# Project Name
newLine 1
appendToFile "# 使用資料夾名稱作為Project名稱"
appendToFile "get_filename_component(ProjectId \${CMAKE_CURRENT_SOURCE_DIR} NAME)"
appendToFile "string(REPLACE \" \" \"_\" ProjectId \${ProjectId})"
appendToFile "PROJECT(\${ProjectId})"


# C++11
newLine 1
appendToFile "# Using C++ 11"
appendToFile "set(CMAKE_CXX_FLAGS		\"-std=c++11\")"

# Source directory
newLine 2
appendToFile "AUX_SOURCE_DIRECTORY(\${CMAKE_CURRENT_LIST_DIR}/src \${ProjectId}_SRC)"

# Sub-directory
newLine 2
appendToFile "# Use the c-build-tool parser to generated"
appendToFile "# add_subdirectory(src/CommonModule)"
appendToFile "# add_subdirectory(src/TitleModule)"
appendToFile "# add_subdirectory(src/ContentModule)"

# Executable
newLine 2
appendToFile "# Generate Executable"
appendToFile "ADD_EXECUTABLE(\${ProjectId} \${\${ProjectId}_SRC}) #執行檔名稱 + source"
appendToFile "target_link_libraries(\${ProjectId} TitleModule ContentModule)"

# Shared Library
newLine 1
appendToFile "# Generate Shared Library"
appendToFile "# add_library(\${ProjectId} SHARED \${\${ProjectId}_SRC}) #Lib名稱 + source"

# Static Library
newLine 1
appendToFile "# Generate Static Library"
appendToFile "# add_library(\${ProjectId} STATIC \${\${ProjectId}_SRC}) #Lib名稱 + source"




