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
$Dominios = @(

    # Roblox
    "roblox.com",
    "www.roblox.com",
    "web.roblox.com",
    "create.roblox.com",

    # Poki
    "poki.com",
    "www.poki.com",

    # Click Jogos
    "clickjogos.com.br",
    "www.clickjogos.com.br",

    # CrazyGames
    "crazygames.com",
    "www.crazygames.com",

    # Friv
    "friv.com",
    "www.friv.com",

    # Now.gg
    "now.gg",
    "www.now.gg",

    # Outros sites de jogos
    "jogos360.com.br",
    "www.jogos360.com.br",
    "1001jogos.com.br",
    "www.1001jogos.com.br",
    "pacogames.com",
    "www.pacogames.com",
    "gamepix.com",
    "www.gamepix.com",
    "minijogos.com.br",
    "www.minijogos.com.br",
    "y8.com",
    "www.y8.com",
    "kongregate.com",
    "www.kongregate.com",
    "armorgames.com",
    "www.armorgames.com",
    "agame.com",
    "www.agame.com",
    "jogostodos.com.br",
    "www.jogostodos.com.br"
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
