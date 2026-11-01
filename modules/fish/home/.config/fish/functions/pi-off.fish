function pi-off --description 'Detiene Hindsight (memoria del agente Pi)'
    docker stop hindsight >/dev/null; and echo "hindsight: off"; or echo "hindsight: error al detener"
end
