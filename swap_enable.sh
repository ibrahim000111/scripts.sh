dd if=/dev/zero of=/mnt/swapfile bs=1024 count=2048k && mkswap /mnt/swapfile && swapon /mnt/swapfile && 
echo /mnt/swapfile none swap defaults 0 0 >> /etc/fstab && chown root:root /mnt/swapfile && chmod 0600 /mnt/swapfile && sysctl vm.swappiness=20 && echo "vm.swappiness=20" >> /etc/sysctl.conf
