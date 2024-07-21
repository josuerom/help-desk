"""
PyScript para la depuración de usuarios automatica en Windows
Autor: @josuerom Fecha: 21/Julio/2024
"""
import os
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
   ctypes.windll.kernel32.SetConsoleTitleW("DEPURADOR DE USUARIOS | ATENTO COLOMBIA 2024 | TELARES")


def consultar_data_usuario() -> list:
   def obtener_usuarios():
      directorio_de_usuarios = r"C:\Users"
      carpetas_excluidas = [
         "admin",
         "prestamo",
         "josue.romero",
         "soporte",
         "public",
         "default",
         "all users",
         "default user",
      ]
      usuarios = [carpeta for carpeta in os.listdir(directorio_de_usuarios) if os.path.isdir(os.path.join(directorio_de_usuarios, carpeta)) and carpeta.lower() not in [ex.lower() for ex in carpetas_excluidas]]
      return usuarios

   HOST = socket.gethostname()
   lista_usuarios = obtener_usuarios()
   contador = 0

   color_print(amarrillo)
   print(f"A CONTINUACION, SE DEPURARAN ({len(lista_usuarios)}) USUARIOS ALOJADOS EN '{HOST}'.\n")

   lsr_definitiva = []

   for usuario in lista_usuarios:
      try:
         contador += 1
         comando = f"Remove-Item C:\\Users\\{usuario} -Recurse -Force"
         lsr_definitiva.append(comando)
         print(lsr[-1])

         comando = f'(Get-WmiObject Win32_UserProfile | Where-Object {{ $_.LocalPath -like "*\\{usuario}" }}).SID'
         sid_process = subprocess.Popen(['powershell.exe', '-Command', comando], stdout=subprocess.PIPE, stderr=subprocess.PIPE, creationflags=subprocess.CREATE_NO_WINDOW)

         stdout, stderr = sid_process.communicate()

         usuario_SID = stdout.strip().decode('utf-8')

         if usuario_SID:
            comando = fr"Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\{usuario_SID}' -Recurse -Force"
            lsr_definitiva.append(comando)
            print(lsr[-1])

         print(f"Usuario {contador}:  [{usuario}]  OBTENIDO.")
      except Exception as e:
         color_print(rojo)
         print(f"Usuario {contador}:  [{usuario}]  NO OBTENIDO.")

   return lsr_definitiva


def contruir_programa_ps1(lsr_definitiva):
   print("\nSE INTENTA CONSTRUIR 'C:\\Users\\Public\\Downloads\\dpu.ps1'.\n")
   ruta_archivo_ps1 = r'C:\Users\Public\Downloads\dpu.ps1'
   with open(ruta_archivo_ps1, 'w') as contenido_archivo_ps1:
      for consulta in lsr_definitiva:
         contenido_archivo_ps1.write(consulta + "\n")

   ejecutar_programa(ruta_archivo_ps1)


def firma_autor():
   locale.setlocale(locale.LC_TIME, 'es_ES.UTF-8')
   fecha = datetime.datetime.now().strftime("%d de %B de %Y")
   color_print(blanco)
   print("********************************************")
   color_print(amarrillo)
   print(f"MIJITO/A SE HAN DEPURADO LOS USUARIOS!\n\nFecha de ejecucion: {fecha}\n\nAUTOR: @josuerom")
   color_print(blanco)
   print("********************************************\n")


def ejecutar_programa(ubicacion_programa):
   color_print(azul)
   print("\nEJECUTANDO EL PROGRAMA 'C:\\Users\\Public\\Downloads\\dpu.ps1'\n")
   try:
      subprocess.run(['powershell.exe', '-Command', ubicacion_programa], capture_output=False, text=True, check=True)
   except subprocess.CalledProcessError as e:
      print(f'ERROR:\n{e.stderr}')


def cerrar_sesion():
   color_print(blanco)
   print("\nEN 5 SEGUNDOS SE CERRARA LA SESION.\n")
   time.sleep(5)
   os.system("shutdown /l /f")
   os._exit(0)


if __name__ == "__main__":
   establecer_marca()
   lista_resultante_definitiva = consultar_data_usuario()
   contruir_programa_ps1(lista_resultante_definitiva)
   firma_autor()
   cerrar_sesion()
