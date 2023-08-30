#!/bin/bash

# Função para verificar a situação do aluno com base nas notas e faltas
verificar_situacao() {
    local nota1b=$1
    local nota2b=$2
    local nota_rs1=$3
    local nota3b=$4
    local nota4b=$5
    local nota_rs2=$6
    local prova_final=$7
    local percentual_faltas=$8

    media_parcial=$(echo "scale=2; ($nota1b + $nota2b + $nota_rs1 + $nota3b + $nota4b + $nota_rs2) / 6" | bc)
    media_final=$(echo "scale=2; ($media_parcial + $prova_final) / 2" | bc)

    if (( $(echo "$percentual_faltas > 25" | bc -l) )); then
        echo "Resultado: Reprovado por falta"
        echo "Situação: Reprovado"
    elif (( $(echo "$media_parcial >= 7" | bc -l) )); then
        echo "Resultado: Aprovado"
        echo "Situação: Aprovado"
    elif (( $(echo "$media_parcial >= 4 && $media_parcial < 7" | bc -l) )); then
        if (( $(echo "$media_final >= 5" | bc -l) )); then
            echo "Resultado: Aprovado após final com média $media_final"
            echo "Situação: Aprovado"
        else
            echo "Resultado: Reprovado após final com média $media_final"
            echo "Situação: Reprovado"
        fi
    else
        echo "Resultado: Reprovado por nota"
        echo "Situação: Reprovado"
    fi
}

# Solicitar entradas do usuário
read -p "Digite a nota da 1ª avaliação bimestral: " nota1b
read -p "Digite a nota da 2ª avaliação bimestral: " nota2b
read -p "Digite a nota da RS1 (se necessário): " nota_rs1
read -p "Digite a nota da 3ª avaliação bimestral: " nota3b
read -p "Digite a nota da 4ª avaliação bimestral: " nota4b
read -p "Digite a nota da RS2 (se necessário): " nota_rs2
read -p "Digite a nota da prova final (se necessário): " prova_final
read -p "Digite o percentual de faltas: " percentual_faltas

# Chamar a função para verificar a situação do aluno
verificar_situacao $nota1b $nota2b $nota_rs1 $nota3b $nota4b $nota_rs2 $prova_final $percentual_faltas
