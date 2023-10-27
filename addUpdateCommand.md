# COMANDOS
Instruções de como adicionar um comando que faz algumas ações automaticamente## Nesse exemplo irei mostrar como criar um comando para atualizar seu sistema com apenas um comando simples no terminal. Você pode usar para outras coisas. 

# Passo 1: 
Abra o seu arquivo de aliases em um editor de texto. Se você não tiver um arquivo de aliases, você pode criar um, por exemplo, ~/.bash_aliases, da seguinte forma:

``` vim ~/.bash_aliases ```

# Passo 2: Adicione o seguinte alias ao arquivo:
```alias update='sudo apt update && sudo apt upgrade -y'```

# Passo 3: Salve o arquivo e saia do editor de texto:
 (No vim: esc + : + w + q)

# Paso 4: Atualize o arquivo de aliases executando o seguinte comando:
```source ~/.bash_aliases```

PRONTO!
AGORORA BASTA USAR O COMANDO: ```update``` 
