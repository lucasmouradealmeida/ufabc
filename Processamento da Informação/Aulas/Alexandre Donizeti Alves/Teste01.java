package teste01;

public class Teste01
{

 static int somarElementos(int v[])
 {
  int soma = 0;
  for (int i = 0; i < v.length; i++)
   soma += v[i];   

  return soma;
 }
 
 static int somarElementos(int v1[], int v2[])
 {
  int soma = 0;
  for (int i = 0; i < v1.length; i++)  
   soma += v1[i];    
  for (int i = 0; i < v2.length; i++)  
   soma += v2[i];    
  
  return soma;
  //return somarElementos(v1) + somarElementos(v2);
 }
 
 static int buscaElemento(int v[], int x)
 {
  for (int i = 0; i < v.length; i++)
  {
   if (v[i] == x)   
    return i;
  }
     
  return -1;   
 }
 
 static int buscaElementoOrdenado(int v[], int x)
 {
  for (int i = 0; i < v.length; i++)
  {
   if (v[i] == x)   
    return i;
   else
    if (v[i] > x)
     break;
  }
  
  return -1;
 } 
 
 static int maiorElemento(int v[])
 {
  int maior = v[0];
  for (int i = 1; i < v.length; i++)
  {
   if (v[i] > maior)   
       maior = v[i];
  }
  
  return maior;
 }
 
 static int menorElemento(int v[])
 {
  int menor = v[0];
  for (int i = 1; i < v.length; i++)
  {
   if (v[i] < menor)   
       menor = v[i];
  }
  
  return menor;
 }
 
 static int[] inverterElementos(int v[])
 {
  int n = v.length, aux; 
  for (int i = 0; i < n / 2; i++)   
  {
   aux = v[i];
   v[i] = v[n - 1 - i];   
   v[n - 1 - i] = aux;
  }
     
  return v;
 }
 
 public static void main(String[] args)
 {
  int v1[] = {1,3,5,7,8,9,10,11,12,13};
  int v2[] = {-30,-10,-50};
  
  //System.out.println( somarElementos(v1) );
  //System.out.println( somarElementos(v1, v2) );
  //System.out.println( buscaElemento(v1, 13));
  //System.out.println( buscaElementoOrdenado(v1, 2));
  
  //System.out.println( maiorElemento (v1) );
  //System.out.println( menorElemento (v2) );
 
  for (int x : inverterElementos (v2) )
    System.out.println( x );
  
  int x[] = inverterElementos( v1 );
  for (int i = 0; i < x.length; i++ )
      System.out.println(x[i]);
 }
}