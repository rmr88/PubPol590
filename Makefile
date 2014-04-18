all: raw_data.dta clean_data.dta Descriptives\supplemental\supplementary_stats.csv Descriptives\tab_health.csv Descriptives\tab_risky.csv Descriptives\tab_demog.csv Descriptives\tab_dv_a.csv Descriptives\tab_dv_b.csv Descriptives\tab_dv_c.csv Results\probabilities.csv Results\table1.xml Results\table2.xml Results\table3.xml Descriptives\fig1_dv.png Descriptives\fig2_dv.png Descriptives\supplemental\fig_dv_a.png Descriptives\supplemental\fig_dv_b.png Descriptives\fig3_risky.png Descriptives\fig4_health.png Descriptives\fig5_income.png Descriptives\supplemental\gender_fig.png Descriptives\supplemental\race_fig.png Descriptives\supplemental\injury_fig.png Descriptives\supplemental\rent_fig.png Results\fig6_model.png Results\fig7_model_volunins.png Results\imputations\impcomp1.xml Results\imputations\impcomp2.xml Results\imputations\impcomp3.xml 

Results\imputations\impcomp1.xml Results\imputations\impcomp2.xml Results\imputations\impcomp3.xml: clean_data.dta Code\imputations.do
	StataSE-64 /e run "Code\imputations.do" 1
	ERASE "imputations.log"

Results\fig6_model.png Results\fig7_model_volunins.png: Results\probabilities.csv Code\figs_model.R
	Rscript Code\figs_model.R

Results\probabilities.csv Results\table1.xml Results\table2.xml Results\table3.xml: clean_data.dta Code\models.do
	StataSE-64 /e run "Code\models.do"
	ERASE "models.log"

Descriptives\fig1_dv.png Descriptives\fig2_dv.png Descriptives\supplemental\fig_dv_a.png Descriptives\supplemental\fig_dv_b.png: Descriptives\tab_dv_a.csv Descriptives\tab_dv_b.csv Descriptives\tab_dv_c.csv Code\figs_dv.R
	Rscript Code\figs_dv.R

Descriptives\fig3_risky.png Descriptives\fig4_health.png Descriptives\fig5_income.png: Descriptives\tab_health.csv Descriptives\tab_risky.csv Descriptives\tab_demog.csv Code\figs_iv.R 
	Rscript Code\figs_iv.R

Descriptives\supplemental\gender_fig.png Descriptives\supplemental\race_fig.png Descriptives\supplemental\injury_fig.png Descriptives\supplemental\rent_fig.png: Descriptives\supplemental\supplementary_stats.csv Code\figs_supplemental.R
	Rscript Code\figs_supplemental.R

Descriptives\tab_dv_a.csv Descriptives\tab_dv_b.csv Descriptives\tab_dv_c.csv Descriptives\tab_health.csv Descriptives\tab_risky.csv Descriptives\tab_demog.csv Descriptives\tab_injury.csv Descriptives\supplemental\supplementary_stats.csv Descriptives\supplemental\additive_index.csv: clean_data.dta Code\descriptives.do
	StataSE-64 /e run "Code\descriptives.do"
	ERASE "descriptives.log"

clean_data.dta: Code\dataset.do Code\missing_data.do raw_data.dta
	StataSE-64 /e run "Code\dataset.do"
	ERASE "dataset.log"

raw_data.dta: Code\dataset_raw.do Code\missing_data.do 
	StataSE-64 /e run "Code\dataset_raw.do"
	ERASE "dataset_raw.log"
