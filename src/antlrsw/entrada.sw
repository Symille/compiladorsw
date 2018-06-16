program exemplo
{
    int: numero;
    
    func int fatorial (int: fat)
    {
        if (fat > 1)
        {
            return (fat * fatorial(fat - 1));
        }
        else
        {
            return (1);
        }
    }
    
    func boolean resultado (int: valor)
    {
        print ("Resultado: ", valor);
        return (TRUE);
    }

    block{
        print ("Fatorial de N. Digite o número?");
        read (numero);
        resultado (fatorial(numero));
    }
}
