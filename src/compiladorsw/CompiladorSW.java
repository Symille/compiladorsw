package compiladorsw;

import antlrsw.GramaticaswLexer;
import antlrsw.GramaticaswParser;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

public class CompiladorSW {
    //pequena alteração
     public static void main(String[] args) throws IOException {
        String fileName = "src/compiladorsw/entrada.sw";
        /* fazer convertar todas a letras para minusculo*/
        InputStream input = new FileInputStream(fileName);
        ANTLRInputStream stream = new ANTLRInputStream(input);
        //Lexico
        GramaticaswLexer lexer = new GramaticaswLexer(stream);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
         System.out.println("quero é passar em complica este perido");
         System.out.println("estao estude muito");
        //Sintatico
        GramaticaswParser parser = new GramaticaswParser(tokens);
        ParseTree tree = parser.prog();
        System.out.println(tree.toStringTree(parser));
                
        //acoes semanticas, atraves de listener
        AcoesSemanticas listener = new AcoesSemanticas();
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk(listener, tree); 
        
        System.out.println("Tabela de Simbolos matematcs");
        System.out.println(listener.getTabSimb());
    }    
}
