# Coisas para decorar
- Formato de instruções em código de máquina:
    + Prefixo: até quatro prefixos de 1 byte
        * Modifica a instrução para 16 bits
        * Também é uso para prevenir disassembly
    + Opcode: 1, 2 ou 3 bytes (obrigatório)
    + Mod R/M: 1 byte (se necessário)
        * Indica como os operandos são usados
        * Formato: MMRRRMMM
            - MM: Modo de endereçamento
            - RRR: Registrador
            - MMM: Endereço ou registrador
        * MM = 00: Primeiro operando é um registrador e o segundo é um endereço em um registrador
        * MM = 01: Primeiro operando é um registrador e o segundo é um endereço em um registrador com deslocamento de 8 bits
        * MM = 10: Primeiro operando é um registrador e o segundo é um endereço em um registrador com deslocamento de 32 bits
        * MM = 11: Primeiro operando é um registrador e o segundo é um registrador
    + SIB: 1 byte (se necessário)
        * Indica como o endereço é calculado
        * Formato: SSIIIBBB
            - SS: Escala
            - III: Índice
            - BBB: Base
        * Endereco = Base + Índice * 2^Escala
    + Deslocamento: 0, 1, 2 ou 4 bytes (se necessário)
    + Constante (imediato): 0, 1, 2 ou 4 bytes (se necessário)
- Interrupções:
    + Salva o estado da CPU
    + Executa uma rotina de serviço (de acordo com uma lista de prioridades)
    + Restaura o estado da CPU
    + Retorna ao processamento anterior
    + Pode ser chamada por software ou hardware interno ou externo
    + Algumas interrupções (de sys call - software):
        * sys_exit: Termina o processo
            + código: 1
            + ebx: código de retorno
        * sys_read: Lê um arquivo
            + código: 3
            + ebx: descritor de arquivo
            + ecx: ponteiro para o buffer
            + edx: número de bytes a serem lidos
            + retorno: número de bytes lidos no EAX
        * sys_write: Escreve em um arquivo
            + código: 4
            + ebx: descritor de arquivo
            + ecx: ponteiro para o buffer
            + edx: número de bytes a serem escritos
            + retorno: número de bytes escritos no EAX
        * sys_open: Abre um arquivo
            + código: 5
            + ebx: ponteiro para o nome do arquivo
            + ecx: modo de abertura - O_RDONLY(0), O_WRONLY(1), O_RDWR(2)
            + edx: permissões
            + retorno: descritor de arquivo no EAX
        * sys_close: Fecha um arquivo
            + código: 6
            + ebx: descritor de arquivo
        * sys_create: Cria um arquivo
            + código: 8
            + ebx: ponteiro para o nome do arquivo
            + ecx: permissões
            + retorno: descritor de arquivo no EAX
- Modos de acesso à memória:
    + Real: Endereços de 20 bits (16 bits efetivos)
        * Sem proteção
        * Até 1 MB de memória
        * Utilizado quando é necessário compatibilidade com versões antigas de 16 bits
        * Segmentos independentes e podem se sobrepor
    + Protegido: Endereços de 32 bits
        * Segmentação
        * Paginação
        * Proteção
        * Multitarefa
        * Multithreading
        * Multicore
    + Forma de segmentação no modo protegido:
        * Seletor de segmento em registradores de segmento
        * Dá um índice para a tabela de descritores de segmento
        * Table indicator: tabela local ou global
        * Requested privilege level: nível de privilégio
        * Usando os registradores de segmento, consulta a base e o limite do segmento
        * Calcula o endereço linear somando o offset ao endereço base
- Modos de endereçamento
    * Register: operandos são registradores - mov eax, ebx
    * Immediate: pelo menos um operando é um valor imediato - mov eax, 10
    * Memory: pelo menos um operando é um endereço de memória
        * Direct: endereço é dado diretamente com uma label - mov eax, [var]
        * Indirect: endereço é dado indiretamente com um registrador 
            * Register-indirect: endereço é dado indiretamente com um registrador - mov eax, [ebx]
            * Based: endereço é dado indiretamente com um registrador e um deslocamento - mov eax, [ebx+4]
            * Indexed: endereço na forma Index * scale + displacement - mov eax, [var+ebx*4]
            * Based-indexed: combinação de based e indexed - mov eax, [ebx+4+ecx*4]
                * Pode ou não ter a escala
- Modo de endereçamento por uso
    * structs: usar o modo based para acessar campos na struct - mov eax, [ebx+4]
    * arrays: usar o modo indexed para acessar elementos do array - mov eax, [var+esi*4]
    * matrizes: usar o modo based-indexed para acessar elementos da matriz - mov eax, [mat+ebx+esi*4]
- ASCII:
    * Algarismos: 0x30 a 0x39
    * Letras maiúsculas: 0x41 a 0x5A
    * Letras minúsculas: 0x61 a 0x7A
- io.mac:
    * PutCh src: escreve um caractere na tela localizado em src
    * PutStr src: escreve uma string na tela (até o caractere nulo)
    * GetCh dest: lê um caractere da entrada padrão e armazena em dest
    * GetStr dest: lê uma string da entrada padrão e armazena em dest
    * PutInt src: escreve um inteiro na tela localizado em src (16 bits)
    * GetInt dest: lê um inteiro da entrada padrão e armazena em dest (16 bits)
    * PutLInt src: escreve um inteiro na tela localizado em src (32 bits)
    * GetLInt dest: lê um inteiro da entrada padrão e armazena em dest (32 bits)
    * newln: pula uma linha
- Overflow x carry:
    * Carry: ocorre quando a operação ultrapassa o limite de bits
    * Overflow: ocorre quando o resultado, considerado como um número com sinal, ultrapassa o limite de bits
    * Jumps:
        * jo: jump if overflow
        * jno: jump if not overflow
        * jc: jump if carry
        * jnc: jump if not carry
- Multiplicão:
    * IMUL: multiplicação com sinal
    * MUL: multiplicação sem sinal
    * Para multiplicar, escolha a quantidade de bits
      + 8 bits: AX = AL * operando
      + 16 bits: DX:AX = AX * operando
      + 32 bits: EDX:EAX = EAX * operando
    * Flags: OF e CF são setados se o resultado não couber em um registrador - tanto para MUL quanto para IMUL
- Divisão:
    * Carregue o divisor em um registrador
    * Para dividir, escolha a quantidade de bits
      + 8 bits: AL = AH:AL / operando - resto em AH
      + 16 bits: AX = DX:AX / operando - resto em DX
      + 32 bits: EAX = EDX:EAX / operando - resto em EDX
    * Necessário extender o sinal antes de dividir
      + cbw: converte byte para word AL -> AX
      + cwd: converte word para doubleword AX -> DX:AX
      + cdq: converte doubleword para quadword EAX -> EDX:EAX
- Tipos de salto
    * Near jump: mesmo segmento
    * Short jump: -128 a 127 bytes
        + Permite saltos mais rápidos com operações aritméticas
    * Far jump: segmento diferente
        + Em modo real: JMP imediato
        + Em modo protegido: 
            * jmp imediato
            * call gate - menor privilégio -> maior privilégio
            * task switch - mesmo privilégio
- Load-operate vs load-store
    * Load-operate: carrega os operandos e executa a operação em um único ciclo
    * Load-store: carrega os operandos, executa a operação e armazena o resultado em três ciclos
    * Load-operate é mais rápido, mas requer hardware mais complexo e caro
    * Hoje em dia, se usa um híbrido dos dois - programa em CISC e executa em RISC
    * O código CISC é convertido em microinstruções RISC



        
