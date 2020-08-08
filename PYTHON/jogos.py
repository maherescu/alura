import forca
import adivinhacao

def escolhe_jogo():
        print("*******************")
        print("Escolha o seu jogo!")
        print("*******************\n")

        print("Digite 1 para Forca ou 2 para Adivinhação")

        jogo = int(input("Qual jogo?"))

        if(jogo == 1):
                print("Jogando Forca")
                forca.jogar()
        elif(jogo ==2):
                print("Jogando Adivinhação")
                adivinhacao.jogar()

if(__name__ == "__main__"):
        escolhe_jogo()