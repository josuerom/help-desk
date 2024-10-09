"""
PyScript para la depuración de usuarios automatica en Windows
Autor: @josuerom Fecha: 08/Octubre/2024
"""
import os
import sys
import time
import socket
import locale
import datetime
import subprocess
import ctypes


amarrillo = 0x06
azul = 0x09
rojo = 0x0C
verde = 0x0A
blanco = 0x07


def color_print(color):
   ctypes.windll.kernel32.SetConsoleTextAttribute(ctypes.windll.kernel32.GetStdHandle(-11), color)


def establecer_marca():
   ctypes.windll.kernel32.SetConsoleIcon(ctypes.windll.kernel32.LoadLibraryW(r".\icono.ico"))
   ctypes.windll.kernel32.SetConsoleTitleW("DEPURADOR DE USUARIOS | ATENTO TELARES 10/2024 | JOSUEROM")


def consultar_data_usuario() -> list:
   def obtener_usuarios():
      directorio_de_usuarios = r"C:\Users"
      carpetas_excluidas = [
         "public",
         "default",
         "soporte",
         "all users",
         "default user",
         "administrador",
         "josue.romero",
         "josuerom",
      ]
      usuarios = [carpeta for carpeta in os.listdir(directorio_de_usuarios) if os.path.isdir(os.path.join(directorio_de_usuarios, carpeta)) and carpeta.lower() not in [ex.lower() for ex in carpetas_excluidas]]
      return usuarios

   HOST = socket.gethostname()
   lista_usuarios = obtener_usuarios()
   contador = 0

   color_print(amarrillo)
   print(f"A CONTINUACION, SE DEPURARAN ({len(lista_usuarios)}) USUARIOS ESCRITOS EN EL EQUIPO '{HOST}'\n")

   lsr_definitiva = []

   for usuario in lista_usuarios:
      try:
         contador += 1
         comando_uno = f"Remove-Item -Path C:\\Users\\{usuario} -Recurse -Force"
         lsr_definitiva.append(comando_uno)

         comando_dos = f'(Get-WmiObject Win32_UserProfile | Where-Object {{ $_.LocalPath -like "*\\{usuario}" }}).SID'
         sid_process = subprocess.Popen(['powershell.exe', '-Command', comando_dos], stdout=subprocess.PIPE, stderr=subprocess.PIPE, creationflags=subprocess.CREATE_NO_WINDOW)
         stdout, stderr = sid_process.communicate()
         usuario_SID = stdout.strip().decode('utf-8')

         if usuario_SID:
            comando_tres = f"Remove-Item -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\{usuario_SID}' -Recurse -Force"
            lsr_definitiva.append(comando_tres)

         color_print(verde)
         print(f"Usuario {contador}:  [{usuario}] -> OBTENIDO.")
      except Exception as e:
         color_print(rojo)
         print(f"Usuario {contador}:  [{usuario}] -> NO OBTENIDO.")

   return lsr_definitiva


def contruir_programa_ps1(lsr_definitiva):
   print("\nSE ESTA CONSTRUYENDO EL SCRIPT 'c:\\Users\\Public\\Documents\\dpu.ps1'.\n")
   ruta_archivo_ps1 = r'c:\users\public\documents\dpu.ps1'
   with open(ruta_archivo_ps1, 'w') as contenido_archivo_ps1:
      for consulta in lsr_definitiva:
         contenido_archivo_ps1.write(consulta + "\n")
   ejecutar_ps1_como_admin(ruta_archivo_ps1)


def ejecutar_ps1_como_admin(ruta_ps1):
   if not os.path.isfile(ruta_ps1):
      print(f"El archivo '{ruta_ps1}' no existe.")
      return
   
   comando = ["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", ruta_ps1]

   try:
      print("EL SCRIPT 'dpu.ps1' ESTÁ EJECUTANDO...\n")
      subprocess.run(comando, check=True)
   except subprocess.CalledProcessError as e:
      print(f"Error al ejecutar el script:\n{e}")
      return


def firma_autor():
   locale.setlocale(locale.LC_TIME, 'es_ES.UTF-8')
   fecha = datetime.datetime.now().strftime("%d de %B de %Y")
   color_print(blanco)
   print("**************************************************\n")
   color_print(amarrillo)
   print(f"MIJITO COMPRUEBE SI SE HAN DEPURADO LOS USUARIOS!\n\nFecha de ejecucion: {fecha}")
   color_print(blanco)
   print("\n**************************************************\n")


def reiniciar():
   s = input("Presione Enter para reiniciar ahora mismo...")
   try:
      subprocess.run(["shutdown", "/r", "/f"], check=True)
   except subprocess.CalledProcessError as e:
      print(f"Error al intentar reiniciar el sistema:\n{e}")


if __name__ == "__main__":
   establecer_marca()
   lista_resultante_definitiva = consultar_data_usuario()
   contruir_programa_ps1(lista_resultante_definitiva)
   firma_autor()
   reiniciar()