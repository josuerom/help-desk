"""
PyScript para la depuración de usuarios automatica en Windows
Autor: @josuerom Fecha: 16/Julio/2024
"""
import os
import time
import socket
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


def eliminar_usuarios():
   def obtener_usuarios():
      directorio_de_usuarios = r"C:\Users"
      carpetas_excluidas = ["admin", "prestamo" "soporte", "public", "all users", "default", "default user"]
      usuarios = [carpeta for carpeta in os.listdir(directorio_de_usuarios) if os.path.isdir(os.path.join(directorio_de_usuarios, carpeta)) and carpeta.lower() not in [ex.lower() for ex in carpetas_excluidas]]
      return usuarios

   lista_usuarios = obtener_usuarios()
   contador, del_exitoso = 0, 0
   host = socket.gethostname()

   color_print(amarrillo)
   print(f"A CONTINUACION SE INTENTARAN ELIMINAR ({len(lista_usuarios)}) RESIDUOS DE USUARIOS DEL HOST '{host}'.\n")

   for usuario in lista_usuarios:
      try:
         contador += 1
         cmd_dirusuario = fr"Remove-Item -Path C:\Users\{usuario} -Recurse -Force"
         estado_uno = subprocess.Popen(['powershell.exe', '-Command', cmd_dirusuario], creationflags=subprocess.CREATE_NO_WINDOW).wait()
         comando = fr'(Get-WmiObject Win32_UserProfile | Where-Object {{ $_.LocalPath -like "*\{usuario}" }}).SID'
         sid_process = subprocess.Popen(['powershell.exe', '-Command', comando], stdout=subprocess.PIPE, stderr=subprocess.PIPE, creationflags=subprocess.CREATE_NO_WINDOW)
         stdout, stderr = sid_process.communicate()
         SID_usuario = stdout.strip().decode('utf-8')
         cmd_definitivo = f"Remove-Item -Path HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\{SID_usuario} -Recurse"
         estado_dos = subprocess.Popen(['powershell.exe', '-Command', cmd_definitivo], creationflags=subprocess.CREATE_NO_WINDOW).wait()
         if estado_uno == 0 and estado_dos == 0:
            del_exitoso += 1
         color_print(verde)
         print(f"Usuario {contador}. [{usuario}]\t\t--> ELIMINADO.")
      except Exception as e:
         color_print(rojo)
         print(f"Usuario {contador}: [{usuario}]\t\t--> NO ELIMINADO.")

   color_print(verde)
   print(f"\nSE ALCANZARON A ELIMINAR ({del_exitoso}) COMPLETAMENTE.\n")


def firma_autor():
   fecha = datetime.datetime.now().strftime("%d/%B/%Y")
   color_print(blanco)
   print("**************************************")
   color_print(amarrillo)
   print(f"MIJITO SE HAN DEPURADO LOS USUARIOS!\nFecha actual: {fecha}\n\nAUTOR: @josuerom")
   color_print(blanco)
   print("**************************************\n")


def cerrar_sesion():
   color_print(azul)
   print("Se cerrara la sesion en pocos segundos...")
   time.sleep(3)
   os.system("shutdown /l /f")


if __name__ == "__main__":
   eliminar_usuarios()
   firma_autor()
   cerrar_sesion()