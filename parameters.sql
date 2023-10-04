-- this will be run by entrypoint adding ALTER DATABASE in front

set yb_enable_optimizer_statistics to on;
set yb_enable_base_scans_cost_model to true;

