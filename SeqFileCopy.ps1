# 指定されたファイルを指定数分、ファイル名を連番にしてコピー

if([string]::IsNullorEmpty($Args[0]))
{
	Write-Host "ファイルが指定されていません"
	exit
}

if(Test-Path $Args[0])
{
	$SrcFilePath = $Args[0]
	$SrcFileName = [System.IO.Path]::GetFileNameWithoutExtension($Args[0])
	$SrcExtension = [System.IO.Path]::GetExtension($Args[0])
}
else
{
	Write-Host "指定されたファイルがありません" 
	exit
}

if([string]::IsNullorEmpty($Args[1]))
{
	Write-Host "コピー数が指定されていません"
	exit
}
else
{
	$a = 0
	if(!(([int]::TryParse($Args[1],[ref]$a)) -and ($Args[1] -gt 0)))
	{
		Write-Host "有効なコピー数が指定されていません"
		exit
	}
}

$endNum = $Args[1]

for( $i=1; $i -le $endNum; $i++ )
{
	$DestFileName = "${SrcFileName}${i}"
	$DestFile = "${DestFileName}${SrcExtension}"
	copy $Args[0] ${DestFile}
}
