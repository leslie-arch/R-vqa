#!/usr/bin/env Rscript

root <- getwd()
setwd(root)

source('R/rcnn_argumentation.R')
source('R/log_utils.R')
source('R/config_utils.R')

.fname <- function()
{
  path <- commandArgs()[4]
  file <- strsplit(path, split = "=|\\.")

  return(file[[1]][[2]])
}

logger <- setup_logging(.fname())

main <- function()
{
  args <- parse_args()
  print(sprintf("start with config:\n[%s]", str(args)))

  if (is.null(args$cfg_file))
  {
    cfg_file = paste0(getwd(), '/extdata/example.yaml')
  }
  else
  {
    cfg_file = args$cfg_file
  }
  print(cfg_file)
  init_config_with_file(cfg_file)

}

if (! interactive())
{
  main()
}
