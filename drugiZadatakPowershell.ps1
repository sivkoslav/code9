$response = Invoke-WebRequest -Uri 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2018-05-19&endtime=2023-05-19&minmagnitude=7' -UseBasicParsing

$object = $response | ConvertFrom-Json


Write-Host "Posle ovoga idu podaci"
$items=@() #inicijalizacija praznog niza

foreach( $zemljotres in $object.features.properties){
   foreach($item in $zemljotres){
        if($item.tsunami -eq 1 -and $item.alert -eq "red"){
            $items+=New-Object -TypeName PSObject -Property ([ordered]@{
            mag=@($item.mag) -join ', '
            place = @($item.place) -join ', '
            tsunami=@($item.tsunami) -join ', '
            alert=@($item.alert) -join ', '
           
            updated=@([timespan]::FromTicks($item.updated).toString()) -join ', '
        
        
        })
        }
        
   
   }



}
$items | Out-String