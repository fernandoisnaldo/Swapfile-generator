#! /bin/bash
echo "Em que diretório completo você deseja que o arquivo swap esteja presente? (eg: /swapfile)"
read swapfile
sudo touch $swapfile
sudo chattr +C $swapfile > /dev/null;
echo "Informe o tamanho do arquivo swap em MB: "
read tamanho
sudo dd if=/dev/zero of=$swapfile bs=1M count=$tamanho status=progress
sudo chmod 600 $swapfile
sudo mkswap $swapfile
sudo swapon $swapfile
echo "Dica: A seguinte linha deve ser adicionada no arquivo /etc/fstab, por meio de um editor de texto com privilégios de root, para que o arquivo swap seja persistente à reinciialização"
echo "$swapfile none swap defaults 0 0 >> /etc/fstab"
exit 0
