*! 1.1.2 Ben Jann 24 Nov 2004
*! 1.1.1 M Blasnik 18 Feb 2004
*Modified by Robbie Richards, 4/2014
cap program drop mat2txt
program define mat2txt
	version 8.2
	syntax , Matrix(name) SAVing(str) Rows(numlist max=1 >0 integer) Cols(numlist max=1 >0 integer) [ REPlace APPend Title(str) Format(str) NOTe(str) ]
	if "`format'"=="" local format "%10.0g"
	local formatn: word count `format'
	local saving: subinstr local saving "." ".", count(local ext)
	if !`ext' local saving "`saving'.csv"
	tempname myfile
	file open `myfile' using "`saving'", write text `append' `replace'
	local nrows=rowsof(`matrix')
	local ncols=colsof(`matrix')
	QuotedFullnames `matrix' row
	QuotedFullnames `matrix' col
	local countcols = 0
	if "`title'" != "" file write `myfile' `"`title'"' _n //title, if specified by user
	
	//column headers:
	if "`replace'" != "" {
		file write `myfile' "Variable," 
		forvalues c = 1/`ncols' {
			local colname: word `c' of `colnames'
			file write `myfile' `"`colname',"'
		}
		file write `myfile' _n
	}
	
	//values:
	forvalues r=1/`nrows' {
		local rowname: word `r' of `rownames'
		if `r' <= `formatn' local fmt: word `r' of `format'
		local countrows = 0
		file write `myfile' `"`rowname',"' //row label
		
		forvalues c = 1/`ncols' { //column values for the current row
			file write `myfile' `fmt' (`matrix'[`r',`c']) ","
			local ++countcols
			local ++countrows
		}
		file write `myfile' _n
	}
	
	if "`note'" != "" file write `myfile' `"`note'"' _n //note, if specified by user
	file close `myfile'
end

capture {
program define QuotedFullnames
	args matrix type
	tempname extract
	local one 1
	local i one
	local j one
	if "`type'"=="row" local i k
	if "`type'"=="col" local j k
	local K = `type'sof(`matrix')
	forv k = 1/`K' {
		mat `extract' = `matrix'[``i''..``i'',``j''..``j'']
		local name: `type'names `extract'
		local eq: `type'eq `extract'
		if `"`eq'"'=="_" local eq
		else local eq `"`eq':"'
		local names `"`names'`"`eq'`name'"' "'
	}
	c_local `type'names `"`names'"'
end
}
