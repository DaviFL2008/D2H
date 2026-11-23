import { Link } from 'react-router-dom';

function MinhaPagina() {
  return (
    <div>
      {/* Conteúdo da página */}
      
      <Link to="/pagina2" className="btn-proximo">
        Próxima Página &rarr;
      </Link>
    </div>
  );
}