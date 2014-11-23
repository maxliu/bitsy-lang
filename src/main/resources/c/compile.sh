#!/bin/bash

clang -emit-llvm -S bitsy.c
llvm-as -f bitsy.ll
llc bitsy.ll