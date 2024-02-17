/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package P2;

/**
 *
 * @author moura.almeida
 */
import java.util.Scanner;

public class ex2 {

    public static void main(String args[]) {
        //Declaração e inicialização de variáveis
        Scanner input = new Scanner(System.in);
        int l, opcao;
        System.out.print("Digite o numero de cidades: ");
        l = input.nextInt();
        String codigo[] = new String[l];
        System.out.print("Digite os " + l + " codigos das cidades: ");
        for (int i = 0; i < l; i++) {
            codigo[i] = input.next().toUpperCase();
        }
        String estado[] = new String[l];
        System.out.print("Digite as " + l + " siglas dos estados: ");
        for (int i = 0; i < l; i++) {
            estado[i] = input.next().toUpperCase();
        }
        int veiculos[] = new int[l];
        System.out.print("Digite os " + l + " numeros de veiculos: ");
        for (int i = 0; i < l; i++) {
            veiculos[i] = input.nextInt();
        }
        int mortes[] = new int[l];
        System.out.print("Digite os " + l + " numeros de mortes: ");
        for (int i = 0; i < l; i++) {
            mortes[i] = input.nextInt();
        }

        //Entrada de dados
        System.out.println("\n--------------------------------");
        System.out.println("MENU: ");
        System.out.print("1 - Calcular Estatistica\t");
        System.out.print("2 - Imprimir Dados\t");
        System.out.print("3 - Sair\t");
        System.out.println("\n--------------------------------");
        System.out.print("Qual sua opção do menu (1, 2 ou 3)? ");
        opcao = input.nextInt();
        while (opcao > 0) {
            switch (opcao) {
                case 1:
                    System.out.print("Estatisticas Calculadas");
                    System.out.println("");
                    estatisticaCidades(codigo, estado, veiculos, mortes);
                    break;
                case 2:
                    imprimir(codigo, estado, veiculos, mortes);
                    break;
                case 3:
                    sair();
                    break;
                default:
                    System.out.println("Opção " + opcao + " escolhida não está cadastrada no nosso sistema .");
            }
            System.out.println("");
            System.out.print("Qual sua opção do menu (1, 2 ou 3)? ");
            opcao = input.nextInt();
        } //fim do while
    }//Fim do método main()

    public static void estatisticaCidades(String[] codigo, String[] estado, int[] veiculos, int[] mortes) {
        //maior e menor mortes
        int maior = mortes[0];
        int menor = mortes[1];
        String c1 = "", c2 = "";
        for (int i = 0; i < codigo.length; i++) {
            if (mortes[i] > maior) {
                maior = mortes[i];
                c1 = codigo[i];
            } else if (mortes[i] < menor) {
                menor = mortes[i];
                c2 = codigo[i];
            }
        }
        System.out.println("Maior numeros de mortes: " + maior + ", ocorrendo na cidade: " + c1);
        System.out.println("Menor numeros de mortes: " + menor + ", ocorrendo na cidade: " + c2);
        //media aritmetica de veiculos nas cidades brasileiras
        int soma = 0;
        for (int i = 0; i < codigo.length; i++) {
            soma = soma + veiculos[i];
        }
        System.out.println("Média de veículos é: " + soma / codigo.length);
        //media aritmetica de acidentes em sp
        soma = 0;
        int q = 0;
        for (int i = 0; i < codigo.length; i++) {
            if ("SP".equals(estado[i])) {
                soma = soma + mortes[i];
                q++;
            }
        }
        System.out.println("Média de mortes em SP: " + soma / q);
    }

    public static void imprimir(String[] codigo, String[] estado, int[] veiculos, int[] mortes) {
        System.out.printf("%-7s %-7s %-20s %10s \n", "Código", "Estado", "Veículos de Passeio", "Pessoas mortas no trânsito");
        for (int i = 0; i < codigo.length; i++) {
            System.out.printf("%-7s %-7s %-20s %-20s \n", codigo[i], estado[i], veiculos[i], mortes[i]);
        }
    }

    public static void sair() {
        System.exit(0);
    }

}
