import 'produto.dart';

/// Catálogo fixo em memória. O aplicativo não usa banco de dados.
class Catalogo {
  static const itens = <Produto>[
    Produto(
      id: 'fone-aura',
      titulo: 'Fone Aura Pro',
      descricao:
          'Cancelamento de ruído e bateria para o dia inteiro. Confortável para trabalho e deslocamento.',
      categoria: 'Áudio',
      preco: 349.90,
      imagemUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF1F6B57,
    ),
    Produto(
      id: 'caixa-pulse',
      titulo: 'Caixa Pulse Mini',
      descricao:
          'Som encorpado em um corpo compacto, com alça e resistência a respingos.',
      categoria: 'Áudio',
      preco: 229.00,
      imagemUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF3E5C76,
    ),
    Produto(
      id: 'relogio-lume',
      titulo: 'Relógio Lume S',
      descricao:
          'Notificações, sono e batimentos no pulso. A pulseira combina com o uso diário.',
      categoria: 'Relógios',
      preco: 599.00,
      imagemUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF8C4A3A,
    ),
    Produto(
      id: 'camera-nara',
      titulo: 'Câmera Nara 24',
      descricao:
          'Sensor nítido, corpo leve e modo automático direto para quem está começando.',
      categoria: 'Foto',
      preco: 1890.00,
      imagemUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF2F4858,
    ),
    Produto(
      id: 'tenis-trilha',
      titulo: 'Tênis Trilha V2',
      descricao:
          'Ajuste estável e amortecimento para caminhada longa e uso no dia a dia.',
      categoria: 'Calçados',
      preco: 429.90,
      imagemUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF6B4C3B,
    ),
    Produto(
      id: 'oculos-bruma',
      titulo: 'Óculos Bruma',
      descricao:
          'Armação de acetato e lentes com proteção solar, em um desenho sóbrio.',
      categoria: 'Acessórios',
      preco: 189.00,
      imagemUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF3D5A4C,
    ),
    Produto(
      id: 'mochila-oficio',
      titulo: 'Mochila Ofício 16',
      descricao:
          'Compartimento para notebook de 16 polegadas e bolso frontal de acesso rápido.',
      categoria: 'Acessórios',
      preco: 259.90,
      imagemUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF4A4458,
    ),
    Produto(
      id: 'teclado-norte',
      titulo: 'Teclado Norte 75',
      descricao:
          'Layout compacto, teclas mecânicas e digitação adequada para o escritório.',
      categoria: 'Informática',
      preco: 479.00,
      imagemUrl:
          'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?auto=format&fit=crop&w=900&q=80',
      cor: 0xFF1E4D5C,
    ),
  ];
}
