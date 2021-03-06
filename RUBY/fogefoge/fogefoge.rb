require_relative 'ui'

def le_mapa(numero)
    arquivo = "mapa#{numero}.txt"
    texto = File.read arquivo
    mapa = texto.split "\n"
end

def encontra_jogador(mapa)
    caractere_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_heroi = linha_atual.index caractere_do_heroi
        if coluna_do_heroi #colocaria != nil para falar que é diferente de vazio, mas se deixar só a variável ele já entende que é "se é algo", então é diferente de vazio
                return [linha, coluna_do_heroi]
        end
    end
    nil
end

def calcula_nova_posicao(heroi, direcao)
    heroi = heroi.dup
    movimentos = {
        "W" => [-1, 0],
        "S" => [+1, 0],
        "A" => [0, -1],
        "D" => [0, +1]
    }
    movimento = movimentos[direcao.upcase]
    heroi[0] += movimento[0]
    heroi[1] += movimento[1]
    heroi
end

def posicao_valida?(mapa, posicao)
    linhas = mapa.size
    colunas = mapa[0].size

    estourou_linhas = posicao[0] < 0 || posicao[0] >= linhas
    estourou_colunas = posicao[1] < 0 || posicao[1] >= colunas

    if estourou_linhas || estourou_colunas
        return false
    end
    valor_local = mapa[posicao[0]][posicao[1]]
    if valor_local == "X" || valor_local == "F"
        return false
    end
    true
end

def soma_vetor(vetor1, vetor2)
    [vetor1[0] + vetor2[0], vetor1[1] + vetor2[1]]
end

def posicoes_validas_a_partir_de(mapa, novo_mapa, posicao)
    posicoes = []
    movimentos = [[+1, 0], [0, +1], [-1, 0], [0, -1]]
    movimentos.each do |movimento|
        nova_posicao = soma_vetor(movimento, posicao)
        if posicao_valida?(mapa, nova_posicao) && posicao_valida?(novo_mapa, nova_posicao)
            posicoes << nova_posicao
        end
    end
    posicoes
end

# def posicoes_validas_a_partir_de(mapa, novo_mapa, posicao)
#     posicoes = []
#     baixo = [posicao[0] + 1, posicao[1]]
#     if posicao_valida?(mapa, baixo) && posicao_valida?(novo_mapa, baixo)
#         posicoes << baixo
#     end
#     direita = [posicao[0], posicao[1] + 1]
#     if posicao_valida?(mapa, direita) && posicao_valida?(novo_mapa, direita)
#         posicoes << direita
#     end
#     cima = [posicao[0] - 1, posicao[1]]
#     if posicao_valida?(mapa, cima) && posicao_valida?(novo_mapa, cima)
#         posicoes << cima
#     end
#     esquerda = [posicao[0], posicao[1] - 1]
#     if posicao_valida?(mapa, esquerda) && posicao_valida?(novo_mapa, esquerda)
#         posicoes << esquerda
#     end
#     posicoes
# end

def move_fantasma(mapa, novo_mapa, linha, coluna)
    posicoes = posicoes_validas_a_partir_de mapa, novo_mapa, [linha, coluna]
    return if posicoes.empty?
    aleatoria = rand posicoes.size
    posicao = posicoes[aleatoria]
    mapa[linha][coluna] = " "
    novo_mapa[posicao[0]][posicao[1]] = "F"
end

def copia_mapa(mapa)
    novo_mapa = mapa.join("\n").tr("F", " ").split "\n"
end

def move_fantasmas(mapa)
    caractere_do_fantasma = "F"
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
        linha_atual.chars.each_with_index do |caractere_atual, coluna|
            eh_fantasma = caractere_atual == caractere_do_fantasma
            if eh_fantasma
                move_fantasma mapa, novo_mapa, linha, coluna
            end
        end
    end
    novo_mapa
end


def jogador_perdeu?(mapa)
    perdeu = !encontra_jogador(mapa) #está falando que se encontra_jogador for nulo ou false vai dar game over
end

def joga(nome)
    #nosso jogo aqui
    mapa = le_mapa 2

    while true
        desenha mapa
        direcao = pede_movimento
        heroi = encontra_jogador mapa
        nova_posicao = calcula_nova_posicao heroi, direcao
        
        if !posicao_valida?(mapa, nova_posicao)
            next
        end
        
        mapa[heroi[0]][heroi[1]] = " "
        mapa[nova_posicao[0]][nova_posicao[1]] = "H"

        mapa = move_fantasmas mapa
        if jogador_perdeu? mapa 
            game_over
            break
        end
    end
end

def inicia_fogefoge
    nome = da_boas_vindas
    joga(nome)
end