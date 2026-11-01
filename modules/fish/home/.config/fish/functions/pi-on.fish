function pi-on --description 'Enciende Hindsight (memoria del agente Pi)'
    docker start hindsight >/dev/null; and echo "hindsight: on"; or echo "hindsight: error al iniciar"
end
