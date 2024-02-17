
import java.util.Scanner;

public class Aula05_02
{
 public static void main(String[] args)
 {
  int contador = 0, contadorSim = 0, contadorNao = 0;
  char resposta;
  
  Scanner entrada = new Scanner(System.in);  
  do
  {
   do
   {
    System.out.print("Voce gosta de futebol? ");
    resposta = entrada.next().toUpperCase().charAt(0);
   } while (!(resposta == 'S' || resposta == 'N'));
   
   if (resposta == 'S')
    contadorSim++;
   else
    contadorNao++;
   
   contador++;
       
  } while (contador < 5);
  
  System.out.println("SIM = " + contadorSim);
  System.out.println("NAO = " + contadorNao);
 }
}