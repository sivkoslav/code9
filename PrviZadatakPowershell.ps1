$response = Invoke-WebRequest -Uri 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-02-01&endtime=2023-05-19&minmagnitude=5' -UseBasicParsing

$object = $response | ConvertFrom-Json


Write-Host "Posle ovoga idu podaci"
$items=@() #inicijalizacija praznog niza

foreach( $zemljotres in $object.features.properties){
   foreach($item in $zemljotres){
        $items+=New-Object -TypeName PSObject -Property ([ordered]@{
            mag=@($item.mag) -join ', '
            place = @($item.place) -join ', '
           
            updated=@([timespan]::FromTicks($item.updated).toString()) -join ', '
        
        
        })
   
   }



}
$items | Out-String

$prosek=0
foreach($i in $items){
    $prosek+=$i.mag


}
Write-Host "Prosecna jacina zemljotresa: "
([decimal]($prosek)/[decimal]($items.Length))

$najmanjaMagnituda=@() #inicijalizacija praznog niza
$najmanjaVrednost= ($items.mag | Measure-Object -Minimum).Minimum
foreach($i in $items){
    if($i.mag -eq $najmanjaVrednost){
        $najmanjaMagnituda+=New-Object -TypeName PSObject -Property ([ordered]@{
            mag=@($item.mag) -join ', '
            place = @($item.place) -join ', '
           
            updated=@([timespan]::FromTicks($item.updated).toString()) -join ', '
        
        
        })
    
    }
    


}
Write-Host "Zemljotresi sa najmanjom magnitudom su:"
$najmanjaMagnituda | Out-String


$maxVrednost= ($items.mag | Measure-Object -Maximum).Maximum #maksimalna magnituda u listi
$najvecaMgnituda=@() #prazan niz

foreach($i in $items){

    if($i.mag -eq $maxVrednost){
    
        $najvecaMgnituda+=New-Object -TypeName PSObject -Property ([ordered]@{
            mag=@($i.mag) -join ', '
            place=@($i.place) -join ', '

        
        
        
        })
    
    
    
    }

}

Write-Host "zemljotresi sa najvecom magnitudom su :"
$najvecaMgnituda | Out-String
 






