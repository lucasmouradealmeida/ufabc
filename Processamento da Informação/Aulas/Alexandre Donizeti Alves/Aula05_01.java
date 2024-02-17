import java.util.Scanner;

public class Aula05_01
{
 public static void main(String[] args)
 {
  float nota, media, acumulador = 0.0f;
  int contador = 0, erros = 0;
  char resposta;
  
  Scanner entrada = new Scanner(System.in);
  do
  {
      
   do
   {
    System.out.print("Entre com uma nota entre 0 e 10: ");
    nota = entrada.nextFloat();
    
    if (nota < 0 || nota > 10)
    {
     erros++;
     
     if (erros == 3)
     {
      System.out.println("Voce errou demais...");
      System.exit(0); // sair do programa 
     }
     else
     {
      System.out.println("Por favor, a nota deve ser entre 0 e 10");
     }
    }
    
   } while (nota < 0 || nota > 10);
   
   acumulador = acumulador + nota;
   contador = contador + 1;
   
   do
   {
    System.out.print("\nDesejar continuar? (s/n): ");
    resposta = entrada.next().toLowerCase().charAt(0);
    
    if (resposta != 's' && resposta != 'n')
    {
     System.out.println("Por favor, digite s ou n");
    }
    
   } while (!(resposta == 's' || resposta == 'n'));
      
  } while (resposta == 's');
  
  media = acumulador / contador;
  System.out.println("\nA media das " + contador + " notas eh " + media);
 }
}