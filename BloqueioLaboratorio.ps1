# =====================================================
# BLOQUEIO DE JOGOS E MICROSOFT STORE - WINDOWS 11 PRO
# Execute como Administrador
# =====================================================

# Verificar privilégios administrativos
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host "Execute este script como Administrador!" -ForegroundColor Red
    Pause
    Exit
}

Write-Host "Iniciando configuracao..." -ForegroundColor Green

# Caminho do arquivo hosts
$HostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

# Lista de domínios a bloquear
# Lista ampliada de domínios
$Dominios = @(

# Roblox
"roblox.com","www.roblox.com","web.roblox.com","create.roblox.com",

# Principais portais de jogos
"poki.com","www.poki.com",
"crazygames.com","www.crazygames.com",
"friv.com","www.friv.com",
"clickjogos.com.br","www.clickjogos.com.br",
"ojogos.com.br","www.ojogos.com.br",
"1001jogos.com.br","www.1001jogos.com.br",
"jogos360.com.br","www.jogos360.com.br",
"minijogos.com.br","www.minijogos.com.br",
"y8.com","www.y8.com",
"agame.com","www.agame.com",
"gamesgames.com","www.gamesgames.com",
"kizi.com","www.kizi.com",
"miniclip.com","www.miniclip.com",
"gamepix.com","www.gamepix.com",
"pacogames.com","www.pacogames.com",
"armorgames.com","www.armorgames.com",
"kongregate.com","www.kongregate.com",
"addictinggames.com","www.addictinggames.com",
"freeonlinegames.com","www.freeonlinegames.com",
"girlsgogames.com","www.girlsgogames.com",
"silvergames.com","www.silvergames.com",
"lagged.com","www.lagged.com",
"a10.com","www.a10.com",
"fliperama.com.br","www.fliperama.com.br",
"jogalo.com","www.jogalo.com",
"jogos.com.br","www.jogos.com.br",

# Jogos .io
"slither.io","www.slither.io",
"agar.io","www.agar.io",
"diep.io","www.diep.io",
"moomoo.io","www.moomoo.io",
"krunker.io","www.krunker.io",
"surviv.io","www.surviv.io",
"shellshock.io","www.shellshock.io",
"paper-io.com","www.paper-io.com",
"paper-io.co","www.paper-io.co",

# Jogos em nuvem e emuladores
"now.gg","www.now.gg",
"cloudbase.gg","www.cloudbase.gg",
"boosteroid.com","www.boosteroid.com",
"geforcenow.com","www.geforcenow.com",
"gaming.microsoft.com",
"xbox.com","www.xbox.com",
"account.xbox.com",

# Plataformas de jogos
"store.steampowered.com",
"steampowered.com",
"epicgames.com","www.epicgames.com",
"store.epicgames.com",

# Downloads de APK
"apkpure.com","www.apkpure.com",
"apkcombo.com","www.apkcombo.com",
"uptodown.com","www.uptodown.com",

# Proxies e desbloqueadores
"croxyproxy.com","www.croxyproxy.com",
"proxysite.com","www.proxysite.com",
"kproxy.com","www.kproxy.com",
"hide.me","www.hide.me",
"hidemyass.com","www.hidemyass.com",

# VPNs populares
"psiphon.ca","www.psiphon.ca",
"protonvpn.com","www.protonvpn.com",
"windscribe.com","www.windscribe.com",
"hotspotshield.com","www.hotspotshield.com",
"betternet.co","www.betternet.co",
"tunnelbear.com","www.tunnelbear.com",
"expressvpn.com","www.expressvpn.com",
"nordvpn.com","www.nordvpn.com",
"surfshark.com","www.surfshark.com",

# Jogos educativos que podem ser usados indevidamente
"coolmathgames.com","www.coolmathgames.com",
"mathplayground.com","www.mathplayground.com",
"hoodamath.com","www.hoodamath.com"
)

Write-Host "Bloqueando sites..." -ForegroundColor Yellow

# Ler conteúdo atual do arquivo hosts
$ConteudoHosts = Get-Content $HostsFile -ErrorAction SilentlyContinue

foreach ($Dominio in $Dominios) {

    $Linha = "127.0.0.1 $Dominio"

    # Adicionar somente se ainda não existir
    if ($ConteudoHosts -notcontains $Linha) {
        Add-Content -Path $HostsFile -Value $Linha
        Write-Host "Bloqueado: $Dominio"
    }
    else {
        Write-Host "Ja existe: $Dominio"
    }
}

# Limpar cache DNS
Write-Host "Atualizando cache DNS..." -ForegroundColor Yellow
ipconfig /flushdns | Out-Null

Write-Host "Sites bloqueados com sucesso." -ForegroundColor Green

# =====================================================
# DESATIVAR MICROSOFT STORE
# =====================================================

Write-Host "Desativando Microsoft Store..." -ForegroundColor Yellow

New-Item `
    -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" `
    -Force | Out-Null

Set-ItemProperty `
    -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" `
    -Name "RemoveWindowsStore" `
    -Type DWord `
    -Value 1

Write-Host "Microsoft Store desativada." -ForegroundColor Green

# =====================================================
# ATUALIZAR POLITICAS
# =====================================================

Write-Host "Atualizando politica..." -ForegroundColor Yellow
gpupdate /force

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " BLOQUEIO CONCLUIDO COM SUCESSO "
Write-Host " Reinicie o computador para garantir tudo."
Write-Host "=============================================" -ForegroundColor Cyan

Pause
