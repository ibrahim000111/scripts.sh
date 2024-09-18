for i in {1..4}
do
  top -bn1 | grep "Cpu(s)" | awk '{print $2}' >> ~/cpu.txt
  sleep 20
done
