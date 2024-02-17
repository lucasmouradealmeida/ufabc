/*O Jogo:
1) o Jogador inicia com 100 reais
2) A cada jogada o jogador joga dois dados
3) Se a soma dos dados for 7 ou 11, o jogador recebe 2*apostado
4) Se a soma não for 7 ou 11, o jogador perde 20 reais
5) O jogo acaba quando o saldo do jogador for menor ou igual a zero
ou quando o jogador decidir para
6) Ao final o programa deverá escrever 
 - O total de dinheiro que o jogador tem
 - Quantas vezes ele ganhou
 - Quantas vezes ele perdeu
 */
//Melhoramentos: Vetor, Matriz, Módulos, Interface Gráfica, etc.
package pi;

/**
 *
 * @author Lucas Moura
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Random;
import java.util.Scanner;
import javax.swing.JOptionPane;
import sun.audio.AudioPlayer;
import sun.audio.AudioStream;

public class Jogob {

    private static String ch;

    public static void PlayMusic(String filepath) {

        InputStream music;
        try {
            music = new FileInputStream(new File(filepath));
            AudioStream audios = new AudioStream(music);
            AudioPlayer.player.start(audios);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error");
        }
    }

    public static void main(String[] args) {
        // Colocar local do arquivo de audio aqui !!!!!!!
        PlayMusic("C:\\Users\\Lucas Moura\\Documents\\NetBeansProjects\\PI\\UndertaleMegalovania.wav");
        double d, aposta = 0;
        int dado1 = 0, dado2 = 0, soma = 0, numVitoria = 0, numDerrota = 0;
        //char ch = 'x';
        String ch = "";
        Random rand = new Random();
        Scanner input = new Scanner(System.in);
        d = 100.00;
        ch = resposta(ch,numVitoria,numDerrota,d);

        while ("S".equals(ch) && d >= 0) {
            for (int i = 0; i < 1; i++) {
                System.out.print("Digite sua aposta: ");
                aposta = input.nextDouble();
                if (aposta > d) {
                    System.out.println("Olokinho meu, ta sem dinheiro");
                    i--;
                }
            }
            dado1 = rand.nextInt(6) + 1;
            dado2 = rand.nextInt(6) + 1;
            soma = dado1 + dado2;

            if (soma == 7 || soma == 11) {
                numVitoria = numVitoria + 1;
                d = d + 2 * aposta;
            } else {
                numDerrota = numDerrota + 1;
                d = d - 20;
            }
            
            if (d==0){
            System.out.println("Vitórias até o momento: " + numVitoria);
            System.out.println("Derrotas até o momento: " + numDerrota);
            System.out.println("Dinheiro que você tem: R$" + d);
            System.exit(0);
            }
            System.out.println("Dado 1: " + dado1);
            System.out.println("Dado 2: " + dado2);
            System.out.println("Vitórias até o momento: " + numVitoria);
            System.out.println("Derrotas até o momento: " + numDerrota);
            System.out.println("Dinheiro que você tem: R$" + d);
            ch = resposta(ch,numVitoria,numDerrota,d);

        } //fim while 

        System.out.println("------------------------");
        System.out.println("Vitórias ao final do jogo: " + numVitoria);
        System.out.println("Derrotas ao final do jogo: " + numDerrota);
        System.out.println("Dinheiro ao final do jogo= " + d);
    }//Fim método main() 

    public static String resposta(String ch, int numVitoria, int numDerrota, double d) {
        Scanner input = new Scanner(System.in);
        System.out.print("\nDeseja jogar (S/N)? ");
        ch = input.nextLine().toUpperCase().replaceAll(" ", "");//.toUpperCase().charAt(0);
        if ("SEMTEMPOIRMAO".equals(ch)) {
            System.out.println("GAME OVINHO");
            System.exit(0);
        }
        while (!"N".equals(ch) & !"S".equals(ch)) {
            System.out.println("Errou");
            System.out.print("Deseja jogar (S/N)? ");
            ch = input.nextLine().toUpperCase().replaceAll(" ", "");//.toUpperCase().charAt(0);
            if ("SEMTEMPOIRMAO".equals(ch)) {
                System.out.println("GAME OVINHO");
                System.exit(0);
            }
        }
        if ("N".equals(ch)) { 
            System.out.println("Vitórias: " + numVitoria);
            System.out.println("Derrotas: " + numDerrota);
            System.out.println("Dinheiro que você tem: R$" + d);
            System.exit(0);
        }
        return ch;
    }
} //Fim da classe

