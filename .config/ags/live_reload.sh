#!/bin/bash
find ./style.scss ./widget -type f | entr -rc ags run
