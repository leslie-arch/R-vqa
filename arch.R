#!/usr/bin/env Rscript

root <- getwd()
setwd(root)

source('R/rcnn_argumentation.R')
source('R/log_utils.R')
source('R/config_utils.R')
source('R/roidb.R')

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

  cfg <- init_config_with_file(cfg_file)
  cfg <- adjust_config_with_args(cfg, args)

  # Dataset
  roidb <- roidb_for_training(cfg)
  print(names(roidb))
  print('---------------------------')

  roidb_t <- get_roidb(roidb,
                       gt_cache = TRUE,
                       proposal_file = NULL,
                       min_proposal_size = 2,
                       proposal_limit = -1,
                       crowd_filter_thresh = 0)
}

if (! interactive())
{
  main()
}

