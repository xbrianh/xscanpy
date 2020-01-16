workflow cbScanpyHCAWorkflow {
	call cbScanpyHCA
}

task cbScanpyHCA {
	String matrix_url
	runtime {
	    docker: "xbrianh/xscanpy"
		memory: "64G"
		cpu: "8"
	}
	command {
		/home/xscanpy/cbScanpyHCA.sh ${matrix_url}
	}
	output {
		File scanpyOutTar = "scanpyOut.tar"
	}
}
