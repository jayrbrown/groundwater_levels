# Copyright 2015 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

library(ggplot2)

# Export data files and charts

# viz.dir <- "/Users/ateucher/dev/bc-env-visualizations/"
attr.out.file <- "out/GW_Well_Attributes.csv"
gwl.out.file <- "out/GWL_Monthly.csv"
pie.png <- "out/figs/status_pie.png"
status.reg.png <- "out/figs/status-by-reg.png"
status.aq.png <- "out/figs/status-by-aq.png"
status.reg.aq.png <- "out/figs/status-by-reg-aq.png"

dir.create("out/figs/", recursive = TRUE, showWarnings=FALSE)

png(pie.png, width=440, height=400)
plot(pie)
dev.off()

png(status.reg.png, width=800, height=400)
plot(reg.plot)
dev.off()

# png(status.aq.png, width=440, height=400)
# plot(aq.plot)
# dev.off()
# 
# png(status.reg.aq.png, width=930, height=330)
# envreportutils::multiplot(reg.plot + theme(legend.position="none"), 
#                           aq.plot + theme(legend.position="none"), 
#                           cols=2, colwidths=c(3,2))
# dev.off()

# Write data files
monthly.out <- monthlywells.ts[monthlywells.ts$nReadings > 0 & 
                                 monthlywells.ts$Well_Num %in% attr.out$Well_Num
                               , c("EMS_ID", "Well_Num","Date","Year", "Month"
                                   ,"med_GWL", "dev_med_GWL", "nReadings")]

write.csv(attr.out, attr.out.file, row.names=FALSE)

write.table(monthly.out, file=gwl.out.file, sep=",", row.names=FALSE)

# Save attributes and monthly values for print version
save(attr.out, monthlywells.ts, file="tmp/analysisData.RData")
