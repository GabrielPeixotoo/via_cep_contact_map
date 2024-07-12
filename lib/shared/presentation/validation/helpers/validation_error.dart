enum ValidationError {
  required(message: 'Campo obrigatório'),
  invalidEmail(message: 'E-mail inválido'),
  invalidCpf(message: 'CPF inválido'),
  invalidPhone(message: 'Telefone inválido'),
  invalidField(message: 'Campo inválido');

  final String message;

  const ValidationError({required this.message});
}
