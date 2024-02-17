
import java.util.Scanner;

public class Aula05_03
{
 public static void main(String[] args)
 {
  int quant, totalVolumes = 0;
  float preco, item, precoTotal = 0;
  
  Scanner entrada = new Scanner(System.in);
  do
  {
   System.out.print("Digite a quantidade: ");
   quant = entrada.nextInt();
   
   if (quant < 0)
   {
    System.out.println("A quantidade deve ser maior que 0");
   }   
   else
   {
    if (quant > 0)
    {
     System.out.print("Digite o preco: ");
     preco = entrada.nextFloat();
    
     totalVolumes = totalVolumes + quant;
     item = preco * quant;
     precoTotal = precoTotal + item;
    }
   }
      
  } while (quant != 0);
     
  System.out.println("\nTotal de volumes = " + totalVolumes);
  System.out.println("Preco total da compra = " + precoTotal);
 }
}