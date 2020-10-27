<#
.SYNOPSIS
Removing empty resource group or groups.

.DESCRIPTION
Function which is meant to remove resource group or resource groups which are found to be empty - without any resources.

.PARAMETER All
Specify parameter All in case you want to check against all resource groups.

.PARAMETER ResourceGroup
Specify parameter ResourceGroup in case you want to check against the specific resource group.

.EXAMPLE
Remove-AzEmptyResourceGroup -All

.EXAMPLE
Remove-AzEmptyResourceGroup -ResourceGroup nemanjajovic-rg
#>
Function Remove-AzEmptyResourceGroup {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        # Specify parameter All in case you want to check against all resource groups.
        [Parameter(Mandatory = $false,
            ParameterSetName = 'All')]
        [switch]$All,
        # Specify parameter ResourceGroup in case you want to check against the specific resource group.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ResourceGroup')]
        [string]$ResourceGroup
    )
    if ($PSCmdlet.ParameterSetName -eq 'All') {
        $ResourceGroupList = (Get-AzResourceGroup).ResourceGroupName
        if ($ResourceGroupList) {
            foreach ($RG in $ResourceGroupList) {
                $CheckResource = (Get-AzResource -ResourceGroupName $RG)
                if ([string]::IsNullOrWhiteSpace($CheckResource)) {
                    Write-Verbose "Removing Resource Group - $RG"
                    [void](Remove-AzResourceGroup -Name $RG -Force -Confirm:$false)
                }
            }
        }
    }
    if ($PSCmdlet.ParameterSetName -eq 'ResourceGroup') {
        $FindResourceGroup = (Get-AzResourceGroup -Name $ResourceGroup -ErrorAction SilentlyContinue)
        if ([string]::IsNullOrWhiteSpace($FindResourceGroup)) {
            Write-Error "Cannot find a resource group with then name $ResourceGroup. Terminatting." -ErrorAction Stop
        }
        else {
            $CheckResource = (Get-AzResource -ResourceGroupName $ResourceGroup)
            if ([string]::IsNullOrWhiteSpace($CheckResource)) {
                Write-Verbose "Removing Resource Group - $ResourceGroup"
                [void](Remove-AzResourceGroup -Name $ResourceGroup -Force -Confirm:$false)
            }
            else {
                Write-Error "Resource Group - $ResourceGroup is not empty. Terminatting." -ErrorAction Stop
            }
        }
    }
}