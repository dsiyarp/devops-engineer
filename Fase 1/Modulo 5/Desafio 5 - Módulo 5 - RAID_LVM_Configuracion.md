
# Configuración de RAID 1 y Volúmenes Lógicos con LVM

## Requisitos
- Ubuntu Server instalado en una máquina virtual o física.
- Dos discos adicionales para configurar el RAID (por ejemplo, `/dev/sdb` y `/dev/sdc`).
- Privilegios de superusuario (`sudo`).

---

## Configuración de RAID 1

### 1. Preparación de los Discos

Listá los discos disponibles e identificá los dos discos que vas a usar para el RAID:

```bash
sudo lsblk
```

### 2. Crear Particiones en los Discos

Usá `fdisk` para crear una partición en cada disco:

```bash
sudo fdisk /dev/sdb
```

1. Presioná `n` para crear una nueva partición.
2. Presioná `p` para hacerla primaria.
3. Aceptá los valores predeterminados.
4. Cambiá el tipo de partición a `fd` (Linux RAID):

   ```bash
   t
   fd
   ```

5. Guardá los cambios con `w`.

Repetí estos pasos para `/dev/sdc`.

### 3. Instalar mdadm

Instalá `mdadm`, la herramienta para la gestión de RAID:

```bash
sudo apt update
sudo apt install mdadm -y
```

### 4. Crear el RAID 1

Creá el RAID 1 usando las particiones:

```bash
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
```

### 5. Verificar el RAID

Chequeá el estado del RAID:

```bash
cat /proc/mdstat
sudo mdadm --detail /dev/md0
```

### 6. Configurar el RAID para que se Inicie Automáticamente

Guardá la configuración del RAID:

```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
```

---

## Configuración de Volúmenes Lógicos con LVM

### 1. Instalar LVM

Instalá el paquete LVM si no está instalado:

```bash
sudo apt install lvm2 -y
```

### 2. Crear Volúmenes Físicos (PV)

Creá un volumen físico a partir del RAID:

```bash
sudo pvcreate /dev/md0
```

### 3. Crear un Grupo de Volúmenes (VG)

Creá un grupo de volúmenes llamado `vg_data`:

```bash
sudo vgcreate vg_data /dev/md0
```

### 4. Crear Volúmenes Lógicos (LV)

Creá un volumen lógico llamado `lv_data`:

```bash
sudo lvcreate -l 100%FREE -n lv_data vg_data
```

### 5. Formatear y Montar el Volumen Lógico

Formateá el volumen lógico con `ext4`:

```bash
sudo mkfs.ext4 /dev/vg_data/lv_data
```

Creá un punto de montaje y montá el volumen lógico:

```bash
sudo mkdir -p /mnt/data
sudo mount /dev/vg_data/lv_data /mnt/data
```

Chequeá el montaje:

```bash
df -h
```

### 6. Configurar el Montaje Automático

Agregá el volumen lógico a `/etc/fstab` para el montaje automático:

```bash
echo '/dev/vg_data/lv_data /mnt/data ext4 defaults 0 0' | sudo tee -a /etc/fstab
sudo mount -a
```

---

## Verificación y Simulación de Recuperación Ante Fallos

### 1. Verificar el Volumen Lógico y RAID

Chequeá que el volumen lógico esté montado y el RAID esté activo:

```bash
lsblk
sudo mdadm --detail /dev/md0
```

### 2. Simular un Fallo de Disco

Marcá un disco como fallido para simular un fallo (por ejemplo, `/dev/sdb1`):

```bash
sudo mdadm --manage /dev/md0 --fail /dev/sdb1
sudo mdadm --manage /dev/md0 --remove /dev/sdb1
```

### 3. Reemplazar el Disco Fallido

Supongamos que reemplazaste el disco fallido con uno nuevo (`/dev/sdd`). Creá una partición:

```bash
sudo fdisk /dev/sdd
```

- Presioná `n` para crear una nueva partición.
- Presioná `p` para hacerla primaria.
- Aceptá los valores predeterminados.
- Cambiá el tipo de partición a RAID (`t -> fd`).
- Guardá los cambios con `w`.

Agregá el nuevo disco al RAID:

```bash
sudo mdadm --manage /dev/md0 --add /dev/sdd1
```

### 4. Verificar la Recuperación del RAID

Chequeá que el RAID se está reconstruyendo:

```bash
cat /proc/mdstat
sudo mdadm --detail /dev/md0
```

Durante la reconstrucción, vas a ver algo como:

```
[======>.............]  resync = 30.0% (XX/1000) finish=10.0min speed=50M/sec
```

Una vez finalizada, ambos discos deberían estar en estado **active sync**.

---

## **Conclusión**

Con estos pasos, configuraste exitosamente un RAID 1 y volúmenes lógicos con LVM en Ubuntu Server. Además, simulaste un fallo de disco y realizaste la recuperación del RAID, mostrando así la capacidad de redundancia y flexibilidad en la gestión del almacenamiento.
