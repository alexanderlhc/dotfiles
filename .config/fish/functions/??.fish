function ??
    switch "$argv[1]"
        case help
            echo "  Usage for ??"
            echo "  --------------------------------------------------"
            echo "  1. Direct Question:  ?? <your question>"
            echo "  2. Piped Input:      cat file.txt | ?? <your question>"
            echo "  --------------------------------------------------"
        case "*"
            if isatty stdin
                fabric-ai --pattern ai $argv
            else
                cat | fabric-ai --pattern ai $argv
            end
    end
end
